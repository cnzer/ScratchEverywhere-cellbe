#include <os.hpp>
// #include <sys/process.h>
// #include <sys/paths.h>
// #include <cell/sysmodule.h>

namespace OS {
bool toExit = false;
bool loadedSettings = false;
std::string *customProjectsPath = nullptr;
} // namespace OS

bool OS::init() {
    // Initialize PS3 system modules
    // cellSysmoduleLoadModule(CELL_SYSMODULE_FS);
    // cellSysmoduleLoadModule(CELL_SYSMODULE_IO);
    // cellSysmoduleLoadModule(CELL_SYSMODULE_NET);
    return true;
}

void OS::deinit() {
    // cellSysmoduleUnloadModule(CELL_SYSMODULE_NET);
    // cellSysmoduleUnloadModule(CELL_SYSMODULE_IO);
    // cellSysmoduleUnloadModule(CELL_SYSMODULE_FS);
}

std::string OS::getPlatform() {
    return "PS3";
}

bool OS::isEnhancedPlatform() {
    return false;
}

std::string OS::getFilesystemRootPrefix() {
    return "/dev_hdd0/";
}

std::string OS::getConfigFolderLocation() {
    return getScratchFolderLocation();
}

std::string OS::getScratchFolderLocation() {
    const std::string custom = getCustomScratchFolderLocation();
    if (!custom.empty()) return custom;
    return getFilesystemRootPrefix() + "game/SCRATCH00000/USRDIR/";
}

std::string OS::getRomFSLocation() {
    return "/app_home/";
}

bool OS::isOnline() {
    // TODO: implement using cellNetCtlGetState
    return false;
}

bool OS::initWifi() {
    // TODO: implement using cellNetCtlInit
    return false;
}

void OS::deInitWifi() {
    // TODO: implement using cellNetCtlTerm
}

std::string OS::getUsername() {
    // TODO: implement using cellUserInfoGet
    return "Player";
}