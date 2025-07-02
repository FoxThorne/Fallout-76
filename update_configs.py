import os
import json
import commentjson
from pathlib import Path

# Set up paths
userprofile = os.environ['USERPROFILE']
base_dir = Path(userprofile) / 'Documents' / 'My Games' / 'Fallout 76'
mod_configs_dir = base_dir / 'Mod Configs'
fox_lists_dir = base_dir / 'Fox Lists'

# Data set mapping
DATASET_MAP = {
    '1_FOX_KEEP': 'FOX_KEEP',
    '2_FOX_STASH': 'FOX_STASH',
    '3_FOX_STASH_QUANTITY': 'FOX_STASH_QUANTITY',
    '4_FOX_DROP_SELL': 'FOX_DROP_SELL',
    '5_FOX_DROP_SELL_QUANTITY': 'FOX_DROP_SELL_QUANTITY',
    '6_FOX_BUY_ALL': 'FOX_BUY_ALL',
    '7_FOX_BUY_MODS': 'FOX_BUY_MODS',
    '8_FOX_BUFFS_CONSUME': 'FOX_BUFFS_CONSUME',
    '9_FOX_BUFFS_TRANSFER': 'FOX_BUFFS_TRANSFER'
}

def load_datasets():
    """Load all JSONC datasets into a dictionary"""
    datasets = {}
    for file in fox_lists_dir.glob('*.jsonc'):
        key = DATASET_MAP.get(file.stem)
        if key:
            with open(file, 'r', encoding='utf-8') as f:
                datasets[key] = commentjson.load(f)
    return datasets

def update_stash_config(datasets):
    """Update inventOmaticStashConfig.json"""
    config_path = mod_configs_dir / 'inventOmaticStashConfig.json'
    with open(config_path, 'r', encoding='utf-8') as f:
        config = json.load(f)
    
    # Update itemNamesGroupConfig section
    if 'itemNamesGroupConfig' in config:
        for key, data in datasets.items():
            if key in config['itemNamesGroupConfig']:
                config['itemNamesGroupConfig'][key] = data
    
    with open(config_path, 'w', encoding='utf-8') as f:
        json.dump(config, f, indent=4)

def update_pipboy_config(datasets):
    """Update inventOmaticPipboyConfig.json"""
    config_path = mod_configs_dir / 'inventOmaticPipboyConfig.json'
    with open(config_path, 'r', encoding='utf-8') as f:
        config = json.load(f)
    
    # Update specific actions
    for action in config:
        if action.get('name') == 'Useless X':
            # Update itemNames with FOX_DROP_SELL_QUANTITY
            if 'FOX_DROP_SELL_QUANTITY' in datasets:
                action['itemNames'] = datasets['FOX_DROP_SELL_QUANTITY']
            
            # Update excluded with FOX_KEEP (if enabled)
            if ('teenoodleTragedyProtection' in action and 
                'excluded' in action['teenoodleTragedyProtection'] and
                'FOX_KEEP' in datasets):
                action['teenoodleTragedyProtection']['excluded'] = datasets['FOX_KEEP']
    
    with open(config_path, 'w', encoding='utf-8') as f:
        json.dump(config, f, indent=4)

if __name__ == '__main__':
    datasets = load_datasets()
    update_stash_config(datasets)
    update_pipboy_config(datasets)
    print("Config files updated successfully!")
