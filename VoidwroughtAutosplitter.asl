state("Voidwrought")
{
    int inGameTimer : "UnityPlayer.dll", 0x1A915C0, 0x0, 0x8, 0x30, 0x70, 0x90, 0x28, 0x20;
    bool isLoading : "UnityPlayer.dll", 0x01B50CC0, 0xD0, 0x8, 0x18, 0xF18;
    string32 scenePrefix : "UnityPlayer.dll", 0x01B50CC0, 0xD0, 0x8, 0x18, 0xF10, 0x14;
}

start
{
    if (current.inGameTimer == 1 && old.inGameTimer != 1) {
        if (settings["one_sec_startup"]) {
            vars.PreviousOffset = timer.Run.Offset;
            timer.Run.Offset = TimeSpan.FromSeconds(1);
        }
        return true;
    }
}

reset
{
    if (current.inGameTimer == 1 && old.inGameTimer > 1)
        return true;
}

isLoading
{
    if (settings["pause_main_menu"] && current.scenePrefix == "Main")
        return true;
    else
        return current.isLoading;
}

onStart
{
    if (settings["one_sec_startup"])
        timer.Run.Offset = vars.PreviousOffset;
}

startup
{
    settings.Add("timer", true, "Timer adjustment");
    settings.Add("pause_main_menu", false, "Pause the timer on main menu", "timer");
    settings.Add("one_sec_startup", false, "Start the timer at 1 second", "timer");
}