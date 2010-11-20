put count my bundle
waitforre ^You flip through the lumpy bundle and find (\d+)
put #var BundleSize.1 $1

put #statusbar 1 Bundle Sizes: $BundleSize.1
put #statusbar 2 Bundle Sizes: $BundleSize.1

put count my other bundle
waitforre ^You flip through the lumpy bundle and find (\d+)
put #var BundleSize.2 $1

put #statusbar 1 Bundle Sizes: $BundleSize.1, $BundleSize.2
put #statusbar 2 Bundle Sizes: $BundleSize.1, $BundleSize.2