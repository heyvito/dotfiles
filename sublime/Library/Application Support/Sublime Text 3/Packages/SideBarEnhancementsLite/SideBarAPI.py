# coding=utf8
import sublime
import os
import re
import shutil


class Object:
    pass


def escapeCMDWindows(string):
    return string.replace("^", "^^")


BINARY = re.compile(
    "\.(psd|ai|cdr|ico|cache|sublime-package|eot|svgz|ttf|woff|zip|tar|gz|rar|bz2|jar|xpi|mov|mpeg|avi|mpg|flv|wmv|mp3|wav|aif|aiff|snd|wma|asf|asx|pcm|pdf|doc|docx|xls|xlsx|ppt|pptx|rtf|sqlite|sqlitedb|fla|swf|exe)$",
    re.I,
)


class SideBarSelection:
    def __init__(self, paths=[]):
        if not paths or len(paths) < 1:
            try:
                path = sublime.active_window().active_view().file_name()
                if self.isNone(path):
                    paths = []
                else:
                    paths = [path]
            except:
                paths = []
        self._paths = paths
        self._paths.sort()
        self._obtained_selection_information_basic = False
        self._obtained_selection_information_extended = False

    def len(self):
        return len(self._paths)

    def hasDirectories(self):
        self._obtainSelectionInformationBasic()
        return self._has_directories

    def hasProjectDirectories(self):
        if self.hasDirectories():
            project_directories = SideBarProject().getDirectories()
            for item in self.getSelectedDirectories():
                if item.path() in project_directories:
                    return True
            return False
        else:
            return False

    def getSelectedItems(self):
        self._obtainSelectionInformationExtended()
        return self._files + self._directories

    def getSelectedItemsWithoutChildItems(self):
        self._obtainSelectionInformationExtended()
        items = []
        for item in self._items_without_containing_child_items:
            items.append(SideBarItem(item, os.path.isdir(item)))
        return items

    def getSelectedDirectories(self):
        self._obtainSelectionInformationExtended()
        return self._directories

    def getSelectedDirectoriesOrDirnames(self):
        self._obtainSelectionInformationExtended()
        return self._directories_or_dirnames

    def _obtainSelectionInformationBasic(self):
        if not self._obtained_selection_information_basic:
            self._obtained_selection_information_basic = True

            self._has_directories = False
            self._has_files = False
            self._only_directories = False
            self._only_files = False

            for path in self._paths:
                if self._has_directories == False and os.path.isdir(path):
                    self._has_directories = True
                if self._has_files == False and os.path.isdir(path) == False:
                    self._has_files = True
                if self._has_files and self._has_directories:
                    break

            if self._has_files and self._has_directories:
                self._only_directories = False
                self._only_files = False
            elif self._has_files:
                self._only_files = True
            elif self._has_directories:
                self._only_directories = True

    def _obtainSelectionInformationExtended(self):
        if not self._obtained_selection_information_extended:
            self._obtained_selection_information_extended = True

            self._directories = []
            self._files = []
            self._directories_or_dirnames = []
            self._items_without_containing_child_items = []

            _directories = []
            _files = []
            _directories_or_dirnames = []
            _items_without_containing_child_items = []

            for path in self._paths:
                if os.path.isdir(path):
                    item = SideBarItem(path, True)
                    if item.path() not in _directories:
                        _directories.append(item.path())
                        self._directories.append(item)
                    if item.path() not in _directories_or_dirnames:
                        _directories_or_dirnames.append(item.path())
                        self._directories_or_dirnames.append(item)
                    _items_without_containing_child_items = (
                        self._itemsWithoutContainingChildItems(
                            _items_without_containing_child_items, item.path()
                        )
                    )
                else:
                    item = SideBarItem(path, False)
                    if item.path() not in _files:
                        _files.append(item.path())
                        self._files.append(item)
                    _items_without_containing_child_items = (
                        self._itemsWithoutContainingChildItems(
                            _items_without_containing_child_items, item.path()
                        )
                    )
                    item = SideBarItem(os.path.dirname(path), True)
                    if item.path() not in _directories_or_dirnames:
                        _directories_or_dirnames.append(item.path())
                        self._directories_or_dirnames.append(item)

            self._items_without_containing_child_items = (
                _items_without_containing_child_items
            )

    def _itemsWithoutContainingChildItems(self, items, item):
        new_list = []
        add = True
        for i in items:
            if i.find(item + "\\") == 0 or i.find(item + "/") == 0:
                continue
            else:
                new_list.append(i)
            if (item + "\\").find(i + "\\") == 0 or (item + "/").find(i + "/") == 0:
                add = False
        if add:
            new_list.append(item)
        return new_list

    def isNone(self, path):
        return (
                path is None
                or path == ""
                or path == "."
                or path == ".."
                or path == "./"
                or path == "../"
                or path == "/"
                or path == "//"
                or path == "\\"
                or path == "\\\\"
                or path == "\\\\\\\\"
                or path == "\\\\?\\"
                or path == "\\\\?"
                or path == "\\\\\\\\?\\\\"
        )


class SideBarProject:
    def getDirectories(self):
        return sublime.active_window().folders()

    def refresh(self):
        sublime.active_window().run_command("refresh_folder_list")


class SideBarItem:
    def __init__(self, path, is_directory):
        self._path = path
        self._is_directory = is_directory

    def path(self, path=""):
        if path == "":
            return self._path
        else:
            self._path = path
            self._is_directory = os.path.isdir(path)
            return path

    def join(self, name):
        return os.path.join(self.path(), name)

    def dirname(self):
        branch, leaf = os.path.split(self.path())
        return branch

    def dirnameCreate(self):
        try:
            self._makedirs(self.dirname())
        except:
            pass

    def name(self):
        branch, leaf = os.path.split(self.path())
        return leaf

    def edit(self):
        if BINARY.search(self.path()):
            return None
        else:
            view = sublime.active_window().open_file(self.path())
            view.settings().set("open_with_edit", True)
            return view

    def isDirectory(self):
        return self._is_directory

    def isFile(self):
        return self.isDirectory() is False

    def reveal(self):
        if sublime.platform() == "windows":
            import subprocess

            if self.isDirectory():
                subprocess.Popen(["explorer", escapeCMDWindows(self.path())])
            else:
                subprocess.Popen(
                    ["explorer", "/select,", escapeCMDWindows(self.path())]
                )
        else:
            sublime.active_window().run_command(
                "open_dir", {"dir": self.dirname(), "file": self.name()}
            )

    def write(self, content):
        with open(self.path(), "w+", encoding="utf8", newline="") as f:
            f.write(str(content))

        if 3000 <= int(sublime.version()) < 3088:
            # Fixes as best as possible a new file permissions issue
            # See https://github.com/titoBouzout/SideBarEnhancements/issues/203
            # See https://github.com/SublimeTextIssues/Core/issues/239
            oldmask = os.umask(0o000)
            if oldmask == 0:
                os.chmod(self.path(), 0o644)
            os.umask(oldmask)

    def extension(self):
        try:
            return (
                re.compile("(\.[^\.]+(\.[^\.]{2,4})?)$")
                    .findall("name" + self.name())[0][0]
                    .lower()
            )
        except:
            return os.path.splitext("name" + self.name())[1].lower()

    def exists(self):
        return os.path.isdir(self.path()) or os.path.isfile(self.path())

    def overwrite(self):
        sublime.message_dialog("Destination already exists")

    def create(self):
        if self.isDirectory():
            self.dirnameCreate()
            self._makedirs(self.path())
        else:
            self.dirnameCreate()
            self.write("")

    def _makedirs(self, path):
        if 3000 <= int(sublime.version()) < 3088:
            # Fixes as best as possible a new directory permissions issue
            # See https://github.com/titoBouzout/SideBarEnhancements/issues/203
            # See https://github.com/SublimeTextIssues/Core/issues/239
            oldmask = os.umask(0o000)
            if oldmask == 0:
                os.makedirs(path, 0o755)
            else:
                os.makedirs(path)
            os.umask(oldmask)
        else:
            os.makedirs(path)

    def move(self, location, replace=False):
        location = SideBarItem(location, os.path.isdir(location))
        if location.exists() and replace == False:
            if self.path().lower() == location.path().lower():
                pass
            else:
                return False
        elif location.exists() and location.isFile():
            os.remove(location.path())

        if self.path().lower() == location.path().lower():
            location.dirnameCreate()
            os.rename(self.path(), location.path() + ".sublime-temp")
            os.rename(location.path() + ".sublime-temp", location.path())
            self._moveMoveViews(self.path(), location.path())
        else:
            location.dirnameCreate()
            if location.exists():
                self.moveRecursive(self.path(), location.path())
            else:
                shutil.move(self.path(), location.path())
            self._moveMoveViews(self.path(), location.path())
        return True

    def moveRecursive(self, _from, _to):
        if os.path.isfile(_from) or os.path.islink(_from):
            try:
                self._makedirs(os.path.dirname(_to))
            except:
                pass
            if os.path.exists(_to):
                os.remove(_to)
            shutil.move(_from, _to)
        else:
            try:
                self._makedirs(_to)
            except:
                pass
            for content in os.listdir(_from):
                __from = os.path.join(_from, content)
                __to = os.path.join(_to, content)
                self.moveRecursive(__from, __to)
            os.rmdir(_from)

    def _moveMoveViews(self, old, location):
        for window in sublime.windows():
            active_view = window.active_view()
            views = []
            for view in window.views():
                if view.file_name():
                    views.append(view)
            views.reverse()
            for view in views:
                if old == view.file_name():
                    self._moveMoveView(
                        window, view, location, active_view
                    )
                elif view.file_name().find(old + "\\") == 0:
                    self._moveMoveView(
                        window,
                        view,
                        view.file_name().replace(old + "\\", location + "\\", 1),
                        active_view,
                    )
                elif view.file_name().find(old + "/") == 0:
                    self._moveMoveView(
                        window,
                        view,
                        view.file_name().replace(old + "/", location + "/", 1),
                        active_view,
                    )

    def _moveMoveView(self, window, view, location, active_view):
        view.retarget(location)

    def views(self):
        path = self.path()
        views = []
        if self.isDirectory():
            for window in sublime.windows():
                for view in window.views():
                    if view.file_name() and (
                            view.file_name().find(path + "\\") == 0
                            or view.file_name().find(path + "/") == 0
                    ):
                        views.append(view)
        else:
            for window in sublime.windows():
                for view in window.views():
                    if view.file_name() and path == view.file_name():
                        views.append(view)
        return views
