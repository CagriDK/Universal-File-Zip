#include <iostream>
#include "string.h"
#include <filesystem>
#include "zip.h"

#include <chrono>

namespace fs = std::filesystem;

bool ZipFile(const char *inputFileName, const char *outZipFileName)
{
    struct zip *archive = zip_open(outZipFileName, ZIP_CREATE | ZIP_TRUNCATE, NULL);

    if (!archive)
    {
        std::cout << "ZIP dosyasini olusturma hatasi!\n";
        return false;
    }

    struct zip_source *source = zip_source_file(archive, inputFileName, 0, 0);

    // ZIP dosyasına dosyayı ekleyin
    int error1 = zip_file_add(archive, inputFileName, source, ZIP_FL_ENC_UTF_8);

    if (error1 < 0)
    {
        std::cout << "Dosya ziplenirken hata olustu: " << zip_strerror(archive) << "\n";
        return false;
    }

    // ZIP dosyasını kapatın
    zip_close(archive);

    printf("Dosya basariyla ziplendi: %s\n", outZipFileName);
    return true;
}

bool ZipDirectory_All(struct zip *archive, const fs::path &inputDirectory, const fs::path &zipRoot = "")
{
    for (const auto &entry : fs::directory_iterator(inputDirectory))
    {
        fs::path filePath = entry.path();
        fs::path zipPath = zipRoot / filePath.filename(); // ZIP içindeki yol

        if (fs::is_directory(filePath))
        {
            if (!ZipDirectory_All(archive, filePath, zipPath))
            {
                return false;
            }
        }
        else
        {
            auto ext = zipPath.string().substr(zipPath.string().find_last_of('.'));
            
            if (ext != ".7z" && ext != ".rar" && ext != ".zip")
            {
                struct zip_source *source = zip_source_file(archive, filePath.string().c_str(), 0, 0);
                if (zip_file_add(archive, zipPath.string().c_str(), source, ZIP_FL_ENC_UTF_8) < 0)
                {
                    std::cout << "Dosya ziplenirken hata olustu: " << zip_strerror(archive) << "\n";
                    return false;
                }
            }
            else{
                continue;
            }
        }
    }
    return true;
}

bool ZipDirectory(const char *inputDirectory, const char *outZipFileName)
{
    // ZIP dosyasını oluşturun veya var olan bir ZIP dosyasını açın

    struct zip *archive = zip_open(outZipFileName, ZIP_CREATE | ZIP_TRUNCATE, NULL);

    if (!archive)
    {
        printf("ZIP dosyasini olusturma hatasi!\n");
        return false;
    }

    bool success = ZipDirectory_All(archive, inputDirectory);

    zip_close(archive);

    if (success)
    {
        std::cout << "Klasor basariyla ziplendi: " << outZipFileName << "\n";
    }

    return success;
}