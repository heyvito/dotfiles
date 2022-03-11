import sublime, sublime_plugin
import os

from .SideBarAPI import SideBarSelection, SideBarItem, SideBarProject


def Window(window=None):
    return window if window else sublime.active_window()


class SideBarRenameCommand(sublime_plugin.WindowCommand):
    def run(self, paths=[], newLeaf=False):
        import functools

        branch, leaf = os.path.split(
            SideBarSelection(paths).getSelectedItems()[0].path()
        )
        Window().run_command("hide_panel")
        view = Window().show_input_panel(
            "New Name:",
            newLeaf or leaf,
            functools.partial(
                self.on_done,
                SideBarSelection(paths).getSelectedItems()[0].path(),
                branch,
            ),
            None,
            None,
        )
        Window().focus_view(view)

        view.sel().clear()
        view.sel().add(
            sublime.Region(
                view.size() - len(SideBarSelection(paths).getSelectedItems()[0].name()),
                view.size()
                - len(SideBarSelection(paths).getSelectedItems()[0].extension()),
            )
        )


class SideBarRevealCommand(sublime_plugin.WindowCommand):
    def run(self, paths=[]):
        if len(paths) > 1:
            paths = SideBarSelection(paths).getSelectedDirectoriesOrDirnames()
        else:
            paths = SideBarSelection(paths).getSelectedItems()
        for item in paths:
            item.reveal()

    def is_enabled(self, paths=[]):
        return SideBarSelection(paths).len() > 0


class SideBarMoveCommand(sublime_plugin.WindowCommand):
    def run(self, paths=[], new=False):
        import functools

        Window().run_command("hide_panel")
        view = Window().show_input_panel(
            "New Location:",
            new or SideBarSelection(paths).getSelectedItems()[0].path(),
            functools.partial(
                self.on_done, SideBarSelection(paths).getSelectedItems()[0].path()
            ),
            None,
            None,
        )
        Window().focus_view(view)

        view.sel().clear()
        view.sel().add(
            sublime.Region(
                view.size() - len(SideBarSelection(paths).getSelectedItems()[0].name()),
                view.size()
                - len(SideBarSelection(paths).getSelectedItems()[0].extension()),
            )
        )

    def on_done(self, old, new):
        item = SideBarItem(old, os.path.isdir(old))
        try:
            if not item.move(new):
                if SideBarItem(new, os.path.isdir(new)).overwrite():
                    self.run()
                else:
                    SideBarMoveCommand(Window()).run([old], new)
                return
        except:
            sublime.error_message("Unable to move:\n\n" + old + "\n\nto\n\n" + new)
            SideBarMoveCommand(Window()).run([old], new)
            raise
        SideBarProject().refresh()

    def is_enabled(self, paths=[]):
        return (
                SideBarSelection(paths).len() == 1
                and SideBarSelection(paths).hasProjectDirectories() is False
        )


class SideBarNewFileCommand(sublime_plugin.WindowCommand):
    def run(self, paths=[], name=""):
        import functools

        Window().run_command("hide_panel")
        view = Window().show_input_panel(
            "File Name:",
            name,
            functools.partial(self.on_done, paths, False),
            None,
            None,
        )
        Window().focus_view(view)

    def on_done(self, paths, relative_to_project, name):
        _paths = paths
        if relative_to_project:
            _paths = SideBarProject().getDirectories()
            if _paths:
                _paths = [SideBarItem(_paths[0], False)]
            if not _paths:
                _paths = SideBarSelection(_paths).getSelectedDirectoriesOrDirnames()
        else:
            _paths = SideBarSelection(_paths).getSelectedDirectoriesOrDirnames()
        if not _paths:
            _paths = SideBarProject().getDirectories()
            if _paths:
                _paths = [SideBarItem(_paths[0], False)]
        if not _paths:
            Window().new_file()
        else:
            for item in _paths:
                item = SideBarItem(item.join(name), False)
                if item.exists():
                    sublime.error_message(
                        "Unable to create file, file or folder exists."
                    )
                    self.run(paths, name)
                    return
                else:
                    try:
                        item.create()
                        item.edit()
                    except:
                        sublime.error_message(
                            "Unable to create file:\n\n" + item.path()
                        )
                        self.run(paths, name)
                        return
            SideBarProject().refresh()


class SideBarNewDirectoryCommand(sublime_plugin.WindowCommand):
    def run(self, paths=[], name=""):
        import functools

        Window().run_command("hide_panel")
        view = Window().show_input_panel(
            "Folder Name:",
            name,
            functools.partial(self.on_done, paths, False),
            None,
            None,
        )
        Window().focus_view(view)

    def on_done(self, paths, relative_to_project, name):
        _paths = paths
        if relative_to_project:
            _paths = SideBarProject().getDirectories()
            if _paths:
                _paths = [SideBarItem(_paths[0], True)]
            if not _paths:
                _paths = SideBarSelection(_paths).getSelectedDirectoriesOrDirnames()
        else:
            _paths = SideBarSelection(_paths).getSelectedDirectoriesOrDirnames()

        for item in _paths:
            item = SideBarItem(item.join(name), True)
            if item.exists():
                sublime.error_message("Unable to create folder, folder or file exists.")
                self.run(paths, name)
                return
            else:
                item.create()
                if not item.exists():
                    sublime.error_message("Unable to create folder:\n\n" + item.path())
                    self.run(paths, name)
                    return
        SideBarProject().refresh()

    def is_enabled(self, paths=[]):
        return SideBarSelection(paths).len() > 0


class SideBarFindInSelectedCommand(sublime_plugin.WindowCommand):
    def run(self, paths=[]):
        window = Window()
        views = []
        for view in window.views():
            if view.name() == "Find Results":

                Window().focus_view(view)

                content = view.substr(sublime.Region(0, view.size()))
                _view = Window().new_file()

                _view.settings().set("auto_indent", False)
                _view.run_command("insert", {"characters": content})
                _view.settings().erase("auto_indent")

                # the space at the end of the name prevents it from being reused by Sublime Text
                # it looks like instead of keeping an internal refrence they just look at the view name -__-
                _view.set_name("Find Results ")
                _view.set_syntax_file(
                    "Packages/Default/Find Results.hidden-tmLanguage"
                )
                _view.sel().clear()
                for sel in view.sel():
                    _view.sel().add(sel)
                _view.set_scratch(True)
                views.append(view)

        for view in views:
            view.close()

        # fill form
        items = []
        for item in SideBarSelection(paths).getSelectedItemsWithoutChildItems():
            items.append(item.path())
        Window().run_command("hide_panel")
        Window().run_command(
            "show_panel", {"panel": "find_in_files", "where": ",".join(items)}
        )

    def is_enabled(self, paths=[]):
        return SideBarSelection(paths).len() > 0
