state("Voidwrought")
{
    int inGameTimer : "UnityPlayer.dll", 0x1A915C0, 0x0, 0x8, 0x30, 0x70, 0x90, 0x28, 0x20;
    bool isLoading : "UnityPlayer.dll", 0x01B50CC0, 0xD0, 0x8, 0x18, 0xF18;
    string32 scenePrefix : "UnityPlayer.dll", 0x01B50CC0, 0xD0, 0x8, 0x18, 0xF10, 0x14;
}

start
{
    if (current.inGameTimer > 1 && old.inGameTimer == 1)
        return true;
}

reset
{
    if (current.inGameTimer == 1 && old.inGameTimer > 1)
        return true;
}

isLoading
{
    return current.scenePrefix == "Main" || current.isLoading;
}