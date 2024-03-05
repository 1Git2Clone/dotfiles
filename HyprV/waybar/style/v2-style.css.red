* {
    border: none;
    border-radius: 100;
    font-family: "JetBrainsMono Nerd Font";
    font-weight: bold;
    font-size: 16px;
    min-height: 0;
}

#cpu {
  border-radius: 100 0 0 100;
}

#memory {
  border-radius: 0;
}

#disk {
  border-radius: 0 100 100 0;
}

#custom-lock_screen {
  border-radius: 100 0 0 100;
}

#custom-updates, #clock {
  border-radius: 0;
}

#custom-power_btn {
  border-radius: 0 100 100 0;
}

window#waybar {
    background: rgba(21, 18, 27, 0);
    color: #ff9999;
}

tooltip {
    background: #2e1e1e;
    opacity: 0.8;
    border-radius: 25px;
    /* border-width: 2px; */
    /* border-style: solid; */
    /* border-color: #11111b; */
}

tooltip label{
    color: #ff9999;
}

#workspaces button {
    padding: 5px;
    color: #cc3333;
    margin-right: 5px;
}

#workspaces button.active {
    color: #ff6666;
}

#workspaces button.focused {
    color: #ff8080;
    background: #eba0ac;
    /* border-radius: 10px; */
}

#workspaces button.urgent {
    color: #b81414;
    background: #a6e3a1;
    /* border-radius: 10px; */
}

#workspaces button:hover {
    background: #1a0000;
    color: #ff9999;
    /* border-radius: 10px; */
}

/* #custom-launch_wofi, */
#custom-lock_screen,
#custom-light_dark,
#custom-power_btn,
#custom-power_profile,
/* #custom-myhyprv, */
#window,
#cpu,
#disk,
#custom-updates,
#memory,
#clock,
#battery,
#pulseaudio,
#network,
#tray,
#temperature,
#workspaces,
#backlight {
    background: #2e1e1e;
    opacity: 0.8;
    padding: 0px 10px;
    margin-top: 10px;
    /* border: 0px; */
}

#tray, #custom-lock_screen, #temperature, #backlight, #custom-launch_wofi, #cpu {
    /* border-radius: 10px 0px 0px 10px; */
}

#custom-light_dark, #workspaces, #battery, #cpu {
    /* border-radius: 0px 10px 10px 0px; */
    margin-left: 12px;
}
#custom-light_dark {
    margin-right: 12px;
}

#temperature.critical {
    color: #e92d4d;
}


#workspaces {
    padding-right: 0px;
    padding-left: 5px;
}

#custom-power_profile {
    color: #a6e3a1;
    /* border-left: 0px; */
    /* border-right: 0px; */
}

#window {
    /* border-radius: 10px; */
    margin-left: 20px;
    margin-right: 20px;
}

/* #custom-launch_wofi { */
/*     color: #fa8989; */
/*     margin-left: 10px; */
/*     border-right: 0px; */
/* } */

#pulseaudio {
    color: #fa8989;
    /* border-left: 0px; */
    /* border-right: 0px; */
}

#pulseaudio.microphone {
    margin-left: 10px;
    color: #fa8989;
    /* border-left: 0px; */
    /* border-right: 0px; */
}

#battery {
    color: #a6e3a1;
    /* border-left: 0px; */
}


/* custom-light_dark { */
/*   width: 50px; */
/* } */




#disk {
  margin-right: 10px
}
