
clear
echo "Starting production build..."
cd constructoria
flutter clean
flutter pub get
flutter build web --release -t "lib/main_production.dart"
cp -r build/web/* publish/
git add .
git commit -m "Production build"
git push
cd ..
echo "Production build completed and pushed."
