# IrfanView Filetype Icon Changer

This tool allows you to easily change the default icons for popular image file formats (.jpeg, .jpg, .png, .gif, .webp) associated with IrfanView on Windows 10/11. It is designed to work with the 64-bit version of IrfanView.

---

## Installation:
1. **Download the repository**: Clone or download this repository to your local machine.
2. **Place Icons in the Correct Folder**: Ensure that the `Icons` folder contains the `.ico` files you want to use for each file format. The default icons should be named accordingly (e.g., `jpeg.ico`, `jpg.ico`, `png.ico`, `gif.ico`, `webp.ico`).
3. **Run the Script**: Execute the provided `run.bat` script to automatically update the filetype icons in the Windows registry.

---

## Usage:
1. **Change Icons**:
   - Run the `run.bat` script to replace the default filetype icons for the supported image formats with your custom icons.
   - The script will copy the icons to a safe location in `ProgramData` and update the registry.

2. **Revert to Default Icons**:
   - To revert the filetype icons to the default IrfanView icons, simply run the `revert.bat` script. It will restore the icon paths to the default IrfanView executable (`i_view64.exe`).


---

## Before and After:
### Before:
![before](https://github.com/user-attachments/assets/8b87c198-652d-4590-956b-d60a31917afc)

### After:
![after](https://github.com/user-attachments/assets/04e0cbc1-ce5a-4b18-ba37-dbbe418a4d1b)
