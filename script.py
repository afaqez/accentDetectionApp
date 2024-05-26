import pandas as pd
import os
import shutil

dataset_path = 'final_dataset/en'
clips_folder = 'final_dataset/en/clips'
us_folder = os.path.join(clips_folder, 'US_files')

# Create the UK_files/US_files directory if it doesn't exist
os.makedirs(us_folder, exist_ok=True)
other_df = pd.read_csv(os.path.join(dataset_path, 'other.tsv'), sep='\t')

def is_uk_accent(accents):
    if pd.isna(accents):
        return False
    return 'England English' in accents

def is_us_accent(accents):
    if pd.isna(accents):
        return False
    return 'United States English' in accents or 'American English' in accents

uk_df = other_df[other_df['accents'].apply(is_uk_accent)]
us_df = other_df[other_df['accents'].apply(is_us_accent)]

uk_files = uk_df['path'].tolist()
us_files = us_df['path'].tolist()

num_uk_files = len(uk_files)
num_us_files = len(us_files)

print(f"Number of UK files: {num_uk_files}")
print(f"Number of US files: {num_us_files}")

count = 0

# # Move UK/US files to the new folder
for file_name in us_files:
    source = os.path.join(clips_folder, file_name)
    destination = os.path.join(us_folder, file_name)    
    os.makedirs(os.path.dirname(destination), exist_ok=True)
    try:
        # Move the file
        shutil.move(source, destination)
        count += 1
        print(count)
    except FileNotFoundError:
        print(f"File not found: {source}. Skipping.")
    if count > 3700:
        break



print("US files have been moved successfully.")
