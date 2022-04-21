using Microsoft.Win32;
using System.Diagnostics;
using TaskbarOverflowCornersFix;

const string KEY_SYS_LIGHT_THEME = "SystemUsesLightTheme";

using (RegistryKey? key = Registry.CurrentUser.OpenSubKey(
    @"Software\Microsoft\Windows\CurrentVersion\Themes\Personalize", 
    true))
    // RegistryKeyPermissionCheck.ReadWriteSubTree,
    // RegistryRights.SetValue
{
    if (key is not null)
    {
        Debug.Assert(new string[]{ KEY_SYS_LIGHT_THEME }.All(key.GetValueNames().Contains));

        int systemUsesLightTheme = (int)key.GetValue(KEY_SYS_LIGHT_THEME)!;
        Debug.Assert(systemUsesLightTheme > -1 && systemUsesLightTheme < 2);

        key.SetValue(KEY_SYS_LIGHT_THEME, systemUsesLightTheme.Turn(), RegistryValueKind.DWord);
        key.SetValue(KEY_SYS_LIGHT_THEME, systemUsesLightTheme, RegistryValueKind.DWord);
    }
}
