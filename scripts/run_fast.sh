#!/bin/bash
# Fast development script
# Use this for quick development runs

# Prevent concurrent builds
export FLUTTER_XCODE_BUILD_SPEED_UP=0
export FLUTTER_BUILD_PARALLEL=1

echo "🚀 Starting safe development mode..."
echo "⚠️  Ensuring no concurrent builds..."

# Kill any existing Flutter processes
pkill -f "flutter" 2>/dev/null || true
sleep 2

echo "🔧 Starting Flutter..."
flutter run -d "iPhone 16 Plus" --debug --no-pub
