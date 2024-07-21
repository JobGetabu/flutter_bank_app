echo '--- getting packages ---'
#flutter pub run build_runner build --delete-conflicting-outputs
melos exec -- "flutter pub get"
echo '--- finished getting packages  ---'