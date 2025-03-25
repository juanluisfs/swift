import json

def remove_localizations(input_filepath, output_filepath, languages_to_remove):

    with open(input_filepath, 'r', encoding='utf-8') as file:      # Load the JSON data from the file
        data = json.load(file)

    for string_key in list(data["strings"].keys()):                 # Remove specified languages from the 'strings' section
        string_data = data["strings"][string_key]
        if "localizations" in string_data:                          # Check if 'localizations' exists before trying to access it
            for lang in languages_to_remove:
                if lang in string_data["localizations"]:
                    del string_data["localizations"][lang]

    with open(output_filepath, 'w', encoding='utf-8') as file:     # Write the updated JSON data back to a file
        json.dump(data, file, indent=2, ensure_ascii=False)


input_filepath      = 'local_in.txt'        # Name of file with all languages       (ie: 'local_in.txt' file in the same directory, so use the relative path)
output_filepath     = 'local_out.txt'       # Name of file with the the new changes (ie: 'local_out.txt' the original or you can overwrite the file if you want)
languages_to_remove = ['de', 'fr']          # Languages to remove                   (in my case, I only wanted to keep the root ('en') language and 'jp')

# Call the function to remove the languages
remove_localizations(input_filepath, output_filepath, languages_to_remove)
