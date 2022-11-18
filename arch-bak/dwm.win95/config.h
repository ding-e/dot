/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int smartgaps          = 1;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const Bool viewontag         = True;     /* Switch view on tag switch */

static const unsigned int gappih    = 5;        /* horiz inner gap between windows */
static const unsigned int gappiv    = 5;        /* vert inner gap between windows */
static const unsigned int gappoh    = 5;        /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 5;        /* vert outer gap between windows and screen edge */

// static const char *fonts[]          = {"monospace:size=10"};
// "Terminus:size=8", "Dina:size=8", "Dina:size=6",
static const char *fonts[]          = {"Terminus:size=10", "WenQuanYi WenQuanYi Bitmap Song:size=9", "TerminessTTF Nerd Font Mono:size=10"};

// static const char dmenufont[]       = "monospace:size=10";
// "Terminus:size=8"; "Dina:size=8";
static const char dmenufont[]       = "Terminus:size=10";

// static const char col_gray1[]       = "#222222";
// static const char col_gray2[]       = "#444444";
// static const char col_gray3[]       = "#bbbbbb";
// static const char col_gray4[]       = "#eeeeee";
// static const char col_cyan[]        = "#005577";

// nord
// static const char col_gray1[]       = "#2E3440"; /* 状态栏 默认 背景色 */
// static const char col_gray2[]       = "#3B4252"; /* 边框 默认 颜色 */
// static const char col_gray3[]       = "#E4E8EF"; /* 状态栏 字体 默认 颜色 */
// static const char col_gray4[]       = "#2E3440"; /* 状态栏 字体 被选中 颜色 */
// static const char col_cyan[]        = "#8EBBBA"; /* 边框与背景 被选中 颜色 */

// win95
static const char col_gray1[]       = "#000000"; /* 状态栏 默认 背景色 */
static const char col_gray2[]       = "#3B4252"; /* 边框 默认 颜色 */
static const char col_gray3[]       = "#FFFFFF"; /* 状态栏 字体 默认 颜色 */
static const char col_gray4[]       = "#FFFFFF"; /* 状态栏 字体 被选中 颜色 */
static const char col_cyan[]        = "#000080"; /* 边框与背景 被选中 颜色 */

// static const unsigned int baralpha = 0xd0;
static const unsigned int baralpha    = OPAQUE;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3]        = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
	[SchemeHid]  = { col_cyan,  col_gray1, col_cyan  },
};
static const unsigned int alphas[][3] = {
	/*               fg      bg        border     */
	[SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
	[SchemeHid]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
//static const char *tags[] = { "one", "two", "three", "four", "fire", "six", "seven", "eight", "ten" };
//static const char *tags[] = { "一", "二", "三", "四", "五", "六", "七", "八", "九" };
//static const char *tags[] = { "main", "web", "code", "irc", "misc", "media"};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
     * -----------------------------------
     *  xprop | grep WM_CLASS
	 */
	/* class      instance    title       tags mask     iscentered   isfloating   monitor */
	// { "Gimp",     NULL,       NULL,       0,            0,           1,           -1 },
	// { "Firefox",  NULL,       NULL,       1 << 8,       0,           0,           -1 },

	{ "Gimp",     NULL,       NULL,              0,          0,           1,           -1 },
    { "Firefox",  NULL,       NULL,              0,          1,           0,           -1 },
	{ "Surf",     NULL,       NULL,              0,          1,           1,           -1 },
	{ "Viewnior", NULL,       NULL,              0,          1,           1,           -1 },
	{ "Catfish",  NULL,       NULL,              0,          1,           1,           -1 },
	{ "Godot",    NULL,       NULL,              0,          0,           1,           -1 },

    { "Firefox",  NULL,       "画中画",          0,          0,           1,           -1 },

    { "Chromium", NULL, "fanyi.youdao.com_/",    0,          1,           1,           -1 },
	{ "Chromium", NULL, "translate.google.cn_/", 0,          1,           1,           -1 },

    // Gnome 计算器
	{ "Gnome-calculator",  "gnome-calculator",   NULL, 0,     1,           1,           -1 },
    // Gnome 日历
	{ "Gnome-calendar",    "gnome-calendar",     NULL, 0,     1,           1,           -1 },
    // Gnome 文件管理器 nautilus
	{ "Org.gnome.Nautilus","org.gnome.Nautilus", NULL, 0,     1,           1,           -1 },
    // Gnome 代办事项 todo
	{ "Gnome-todo",        "gnome-todo",         NULL, 0,     1,           1,           -1 },
    // Gnome 日志
	{ "Gnome-logs",        "gnome-logs",         NULL, 0,     1,           1,           -1 },
    // Gnome 字体查看
	{ "Gnome-font-viewer", "gnome-font-viewer",  NULL, 0,     1,           1,           -1 },
    // Gnome 磁盘使用情况分析
	{ "Baobab",            "baobab",             NULL, 0,     1,           1,           -1 },
    // Gnome 防火墙 gufw
	{ "Gufw.py",           "gufw.py",            NULL, 0,     1,           1,           -1 },
    // Gnome 网络配置
	{ "Nm-connection-editor","nm-connection-editor",NULL, 0,  1,           1,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod1Mask
//#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
// -b 屏幕底部:  { "dmenu_run", "-b", ..., NULL };   不加参数 -b，则在顶部
static const char *dmenucmd[] = { "dmenu_run", "-b", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
// 默认终端
static const char *termcmd[]  = { "alacritty", NULL }; // { "st", NULL };

// ==========================================
// rofi
// { "rofi", "-show", "run" };
// { "rofi", "-show", "combi", "-combi-modi", "run#drun#window", "-modi", "combi", NULL};
static const char *rofi_cmd[]     = { "rofi", "-show", "combi", "-combi-modi", "drun#window", "-modi", "combi", NULL};
// launch categorized menu
static const char *morcmenu_cmd[] = { "morc_menu", NULL};

// scratchpad - alacritty, st - 120x34 / 90x28
static const char scratchpadname[]     = "scratchpad";
// { "alacritty", "-t", scratchpadname, "-d", "120", "34", NULL };
static const char *scratchpad_cmd[]    = { "st", "-t", scratchpadname, "-g", "90x28", NULL };

// tmux scratchpad - alacritty, st - 160x45 / 200x53 / 210x63 / 150x50 / 150x45
static const char tmuxscratchpadname[] = "tmux-scratchpad";
// { "alacritty", "-t", tmuxscratchpadname, "-d", "160", "45", "-e", "tmux", NULL };
static const char *tmux_cmd[]          = { "st", "-t", tmuxscratchpadname, "-g", "150x45", "-e", "tmux", NULL };

// alsamixer - alacritty, st, terminal - 120x34 / 90x28
// { "alacritty", "-t", scratchpadname, "-d", "120", "34", "-e", "alsamixer", NULL };
static const char *alsamixer_cmd[]     = { "st", "-t", scratchpadname, "-g", "90x28", "-e", "alsamixer", NULL };

// 锁屏 xfce4-screensaver lock screen
// { "xfce4-screensaver-command", "--lock", NULL};
static const char *lockscreen_cmd[]    = { "firejail", "--private", "--net=none", "xfce4-screensaver-command", "--lock", NULL};
// 截图
static const char *flameshot_cmd[]     = { "firejail", "--net=none", "flameshot", "gui", NULL};

// static const char *browser_cmd[]    = { "google-chrome-stable", NULL };
// static const char *browser_cmd[]    = { "chromium", NULL };
// static const char *thunar_cmd[]     = {"thunar", NULL};

// ==========================================
// 脚本路径 相关命令
static const char xlock_path[]               = "/home/dinge/core/scripts/dwm-scripts/slock-lockscreen.sh";
static const char trayer_path[]              = "/home/dinge/core/scripts/dwm-scripts/tray-toggle.sh";
static const char xrandr_multi_path[]        = "/home/dinge/core/scripts/dwm-scripts/xrandr-multi.sh";
static const char xrandr_copy_path[]         = "/home/dinge/core/scripts/dwm-scripts/xrandr-copy.sh";
static const char xrandr_once_path[]         = "/home/dinge/core/scripts/dwm-scripts/xrandr-once.sh";
static const char feh_wpchange_path[]        = "/home/dinge/core/scripts/dwm-scripts/wp-change.sh";
static const char dwmstatus_change_path[]    = "/home/dinge/core/scripts/dwm-scripts/dwm-status/c-toggle-status-type.sh";
static const char firejail_list_path[]       = "/home/dinge/core/scripts/dwm-scripts/firejail-list.sh";
static const char system_info_path[]         = "/home/dinge/core/scripts/dwm-scripts/dwm-status/dwm-cat-system-status.sh";
static const char dinge_autostart_path[]     = "/home/dinge/core/scripts/dwm-scripts/dinge-autostart.sh";

static const char vim_keymap_help_path[]     = "/home/dinge/core/picture/dwm.open/vim-keymap.gif";
static const char vim_simplenote_help_path[] = "/home/dinge/core/picture/dwm.open/vim-notes.jpg";

// -------------------------
// 锁屏 xlock lock screen
// static const char *lockscreen_cmd[]        = { "slock", NULL };
// static const char *lockscreen_cmd[]        = { xlock_path, NULL };
static const char *trayer_cmd[]            = { trayer_path, NULL };           // 任务栏 - trayer
static const char *xrandr_multi_cmd[]      = { xrandr_multi_path, NULL };     // xrandr 双显示器，扩展显示
static const char *xrandr_copy_cmd[]       = { xrandr_copy_path, NULL };      // xrandr 双显示器，镜像显示
static const char *xrandr_once_cmd[]       = { xrandr_once_path, NULL };      // xrandr 单显示器，禁用另外一台显示器
static const char *feh_wpchange_cmd[]      = { feh_wpchange_path, NULL };     // feh切换墙纸
static const char *dwmstatus_change_cmd[]  = { dwmstatus_change_path, NULL }; // 切换dwm状态显示 修改状态类型的number(dwm状态栏) 脚本
static const char *firejail_list_cmd[]     = { firejail_list_path, NULL };    // 查看firejail --list - 通知弹窗
static const char *system_info_cmd[]       = { system_info_path, NULL };      // 查看系统状态信息 脚本
static const char *dinge_autostart_cmd[]   = { dinge_autostart_path, NULL };  // 快速打开软件 脚本

// 打开vim键位帮助图
static const char *vim_keymap_help_cmd[]      = { "firejail", "--net=none", "viewnior", vim_keymap_help_path, NULL }; 
static const char *vim_simplenote_help_cmd[]  = { "firejail", "--net=none", "viewnior", vim_simplenote_help_path, NULL };

// ==========================================
// { "firefox", "--new-tab",    "https://translate.google.cn/", ...,  NULL };
// { "firefox", "--new-tab",    "http://fanyi.youdao.com/", ...,  NULL };
// { "firefox", "--new-window", "http://fanyi.youdao.com/", ...,  NULL };

// chromium google/有道 翻译 - 1480 x 900 / 1080,650
// static const char *chrome_youdao_fanyi_cmd[] = { "firejail", "--private", "chromium", "--window-size=1080,650", "--app=http://fanyi.youdao.com/",  NULL };
// static const char *chrome_google_fanyi_cmd[] = { "firejail", "--private", "chromium", "--window-size=1080,650", "--app=https://translate.google.cn/",  NULL };

// 因为使用snap 安装的chromium，因此不能再用firejail包装一层运行
static const char *chrome_youdao_fanyi_cmd[] = { "/snap/bin/chromium", "--window-size=1080,650", "--app=http://fanyi.youdao.com/",  NULL };
static const char *chrome_google_fanyi_cmd[] = { "/snap/bin/chromium", "--window-size=1080,650", "--app=https://translate.google.cn/",  NULL };
//static const char *firefox_youdao_fanyi_cmd[] = { "/snap/bin/firefox", "--new-window", "http://fanyi.youdao.com/", "--window-size", "1080,650", NULL };
//static const char *firefox_google_fanyi_cmd[] = { "/snap/bin/firefox", "--new-window", "http://translate.google.cn/", "--window-size", "1080,650", NULL };

// ==========================================
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },

	// 当前窗口的应用程序中焦点切换 (以前j为+1，k为-1, 不符合习惯，互换一下)
	{ MODKEY,                       XK_k,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = -1 } },

    // 选中 当前窗口下一个程序 / 上一个程序 - 为了纯右手可以切换，多定一个
    { MODKEY,                       XK_e,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_w,      focusstack,     {.i = -1 } },

	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	// { MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY|ShiftMask|ControlMask, XK_q,      quit,           {0} },

	// ==========================================
	// rofi menu
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = rofi_cmd } },
	// morc_menu
	{ MODKEY|ShiftMask|ControlMask, XK_p,      spawn,          {.v = morcmenu_cmd } },
	// trayer 托盘
	{ MODKEY|ShiftMask,             XK_t,      spawn,          {.v = trayer_cmd } },

	// alsamixer 音量
	{ MODKEY|ControlMask,           XK_m,      spawn,          {.v = alsamixer_cmd } },
	// lock screen 锁屏
	{ MODKEY|ControlMask,           XK_l,      spawn,          {.v = lockscreen_cmd } },
	// flameshot 截图
	{ MODKEY|ControlMask,           XK_a,      spawn,          {.v = flameshot_cmd } },

    // feh切换墙纸
	{ MODKEY|ShiftMask|ControlMask, XK_m,      spawn,          {.v = feh_wpchange_cmd } },

    // chromium google/youdao 翻译
	{ MODKEY|ShiftMask,             XK_r,      spawn,          {.v = chrome_youdao_fanyi_cmd } },
	{ MODKEY|ShiftMask|ControlMask, XK_r,      spawn,          {.v = chrome_google_fanyi_cmd } },

    // xrandr 双显示器，扩展显示
	{ MODKEY|ShiftMask,             XK_y,      spawn,          {.v = xrandr_multi_cmd } },
    // xrandr 双显示器，镜像显示
	{ MODKEY|ShiftMask|ControlMask, XK_y,      spawn,          {.v = xrandr_copy_cmd } },
    // xrandr 单显示器，禁用另外一台显示器
	{ MODKEY|ControlMask,           XK_y,      spawn,          {.v = xrandr_once_cmd } },

    // 修改状态类型的number(dwm状态栏) 脚本
	{ MODKEY|ShiftMask|ControlMask, XK_s,      spawn,          {.v = dwmstatus_change_cmd } },
    // 查看firejail --list - 通知弹窗
	{ MODKEY|ShiftMask|ControlMask, XK_f,      spawn,          {.v = firejail_list_cmd } },
    // 查看系统状态信息 脚本
	{ MODKEY|ShiftMask|ControlMask, XK_d,      spawn,          {.v = system_info_cmd } },
    // 快速打开软件 脚本
	{ MODKEY|ShiftMask|ControlMask, XK_n,      spawn,          {.v = dinge_autostart_cmd } },
    // 打开vim键位帮助图
	{ MODKEY|ShiftMask|ControlMask, XK_u,      spawn,          {.v = vim_keymap_help_cmd } },
	{ MODKEY|ShiftMask|ControlMask, XK_o,      spawn,          {.v = vim_simplenote_help_cmd } },

	// ----------------------

	// dwm-hide-and-restore-THENICEBOY--TODO-BUG-current.diff
	{ MODKEY,                       XK_v,      hidewin,        {0} },
	{ MODKEY|ShiftMask,             XK_v,      restorewin,     {0} },

	// dwm-focusadjacenttag-6.0.diff
	{ MODKEY,                       XK_u,      viewtoleft,     {0} }, // XK_Left
	{ MODKEY,                       XK_o,      viewtoright,    {0} }, // XK_Right
	{ MODKEY|ShiftMask,             XK_u,      tagtoleft,      {0} }, // XK_Left
	{ MODKEY|ShiftMask,             XK_o,      tagtoright,     {0} }, // XK_Right

	// dwm-fullscreen-6.2.diff
	{ MODKEY|ShiftMask,             XK_f,      fullscreen,     {0} },

	// dwm-rotatestack-20161021-ab9571b.diff
	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = -1 } },

	// dwm-scratchpad-6.2.diff
	// dwm-scratchpad grave键 === ` 键
	{ MODKEY,                       XK_r,      togglescratch,  {.v = scratchpad_cmd } },

	// dwm-scratchpad-tmux-DINGE-6.2.diff
	// tmux
	{ MODKEY,                       XK_grave,  toggletmuxscratch, {.v = tmux_cmd } },

	// dwm-vanitygaps-20200610-f09418b.diff
	// 这些快捷键主要用来调试四周间隙和应用与应用之间的间隙大小
    // { MODKEY|Mod4Mask,              XK_w,      incrgaps,       {.i = +1 } }, // XK_h
	// { MODKEY|Mod4Mask,              XK_r,      incrgaps,       {.i = -1 } }, // XK_l
	// { MODKEY|Mod4Mask|ShiftMask,    XK_w,      incrogaps,      {.i = +1 } }, // XK_h
	// { MODKEY|Mod4Mask|ShiftMask,    XK_r,      incrogaps,      {.i = -1 } }, // XK_l
	// { MODKEY|Mod4Mask|ControlMask,  XK_w,      incrigaps,      {.i = +1 } }, // XK_h
	// { MODKEY|Mod4Mask|ControlMask,  XK_r,      incrigaps,      {.i = -1 } }, // XK_l
	// { MODKEY|Mod4Mask,              XK_0,      togglegaps,     {0} },
	// { MODKEY|Mod4Mask|ShiftMask,    XK_0,      defaultgaps,    {0} },
	// { MODKEY,                       XK_y,      incrihgaps,     {.i = +1 } },
	// { MODKEY,                       XK_o,      incrihgaps,     {.i = -1 } },
	// { MODKEY|ControlMask,           XK_y,      incrivgaps,     {.i = +1 } },
	// { MODKEY|ControlMask,           XK_o,      incrivgaps,     {.i = -1 } },
	// { MODKEY|Mod4Mask,              XK_y,      incrohgaps,     {.i = +1 } },
	// { MODKEY|Mod4Mask,              XK_o,      incrohgaps,     {.i = -1 } },
	// { MODKEY|ShiftMask,             XK_y,      incrovgaps,     {.i = +1 } },
	// { MODKEY|ShiftMask,             XK_o,      incrovgaps,     {.i = -1 } },
	// =========================================
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },

	// =========================================
	// dwm-awesomebar-20200829-6.2-current
	{ ClkWinTitle,          0,              Button1,        togglewin,      {0} },
	// =========================================
};

