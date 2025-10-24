
DIRECTORY=$(pwd)

cd "$DIRECTORY" || { echo "Directory not found!"; exit 1; }

echo "Finding top 10 largest files in $DIRECTORY ..."

top_files=$(find . -type f -exec du -b {} + | sort -nr | head -n 10 | awk '{print $2}')

if [ -z "$top_files" ]; then
  echo "No files found!"
  exit 1
fi


echo "Creating archive Compressed_Files.tar.gz..."
tar -czf Compressed_Files.tar.gz $top_files

if [ $? -eq 0 ]; then
  echo "Removing original files..."
  rm -f $top_files
  echo "✅ Done! Created Compressed_Files.tar.gz and removed originals."
else
  echo "❌ Archive creation failed!"
  exit 1
fi
