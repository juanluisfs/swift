/*
1. Add the shortTitle and systemImageName parameters in your AppShortcut(). If none of your shortcuts have this, the coloured panel won't appear in Shortcuts app.
2. Create colours in your main app's asset catalog (e.g. ShortcutsBackground1, ShortcutsBackground2 and ShortcutsForeground)
3. Add NSAppIconActionTintColorName and NSAppIconComplementingColorNames in your Info.plist. This needs to go within CFBundlePrimaryIcon.
For example:
*/

<dict>
    <key>CFBundleIcons</key>
    <dict>
		<key>CFBundlePrimaryIcon</key>
		<dict>
			<key>NSAppIconActionTintColorName</key>
			<string>ShortcutsForeground</string>
			<key>NSAppIconComplementingColorNames</key>
			<array>
				<string>ShortcutsBackground1</string>
				<string>ShortcutsBackground2</string>
			</array>
		</dict>
    </dict>
</dict>

[For more info, check Apple Developer Documentation](https://developer.apple.com/documentation/bundleresources/information_property_list/cfbundleicons/cfbundleprimaryicon/nsappiconcomplementingcolornames)
