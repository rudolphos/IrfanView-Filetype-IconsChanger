# IrfanView Filetype Icon Changer

This script allows you to easily change the default icons for the most widely used image file formats (.jpeg, .jpg, .png, .gif, .webp) associated with IrfanView (64-bit) on Windows 10/11.

The icons included in this pack are selected to be visually distinct. Even when zoomed out to the smallest icon size (16x16), each image format (e.g., `.jpeg`, `.jpg`, `.png`, `.gif`, `.webp`) is easily distinguishable by color. This ensures that each file type is identifiable in File Explorer's "Detail" view, where icons can be very small in compact mode.

![image](https://github.com/user-attachments/assets/c98365e5-6cf5-4eb6-8d37-53e2462fd4f9)

---

## Installation:
1. **Download the repository**: Clone or download this repository to your local machine.
2. **Place Icons in the Correct Folder**: Ensure that the `Icon` folder contains the `.ico` files you want to use for each file format. The default icons should be named accordingly (e.g., `jpeg.ico`, `jpg.ico`, `png.ico`, `gif.ico`, `webp.ico`). By default there are a few basic icons provided already, but if you want to use a custom icon pack, you can do that as well, by placing all of the .ico files in the `Icon` folder.
For example, some can be downloaded from: https://imageglass.org/extension-icon/adobe-icons-set-xmha97-4

4. **Run the Script**: Execute the provided `run.bat` script to automatically update the filetype icons in the Windows registry (e.g., `HKEY_CLASSES_ROOT\IrfanView.xxx\DefaultIcon`).

---

## Usage:
1. **Change Icons**:
   - Run the `run.bat` script As Administrator to replace the default filetype icons for the supported image formats with your custom icons.
   - The script will copy the icons to a safe location in `ProgramData` and update the registry.

2. **Revert to Default Icons**:
   - To revert the filetype icons to the default IrfanView icons, run the `revert.bat` script. It will restore the icon paths to the default IrfanView executable (`i_view64.exe`).


---

## Before and After:
### Before:
![before](https://github.com/user-attachments/assets/8b87c198-652d-4590-956b-d60a31917afc)

### After:
![after](https://github.com/user-attachments/assets/04e0cbc1-ce5a-4b18-ba37-dbbe418a4d1b)
