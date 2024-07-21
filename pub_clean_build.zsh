echo '--- getting packages ---'
#flutter pub run build_runner build --delete-conflicting-outputs
melos exec -- "flutter clean"
melos clean
echo '--- finished getting packages  ---'