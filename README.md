# GEONU: A Flexible Framework for Geoneutrino Signal Modeling

GEONU is a modular and extensible MATLAB-based framework for calculating geoneutrino signals, with a focus on lithospheric modeling, mantle contributions, and neutrino oscillation effects. It supports various geological and physical models and is tailored for applications in geoneutrino signal analyses.
This repository is a revised and extended version based on the original GEONU codebase available at [GEONU](https://github.com/LSKgeo/GEONU), developed specifically to support geoneutrino studies for the SNO+ experiment.

## Features

- **Modular Structure**: Clean separation between lithospheric modeling, mantle assumptions, physics parameters, and analysis scripts.
- **Flexible Inputs**: Easily configurable Earth models, abundances, and physical constants.
- **Neutrino Oscillation Support**: Full implementation of oscillation parameter dependencies.
- **Advanced Applications**: Includes tools for estimating flux, radiogenic heat power, and signal rates under various scenarios.
- **Documentation**: Bilingual user manual (Chinese + English), technical notes, and figures provided.

## Usage

1. Clone the repository.
2. Open MATLAB and add the repository to your path.
3. Start with `LITE-main.mlx` to understand the core structure.
4. Move on to `ADVANCE-main.mlx` or `SPECTRUM-main.mlx` for advanced analyses.
5. Refer to the documentation in `Docs/` for step-by-step guidance.

## Authorship and Attribution

This project was developed by [Shuai Ouyang], building upon previous work from an early version of [GEONU](https://github.com/LSKgeo/GEONU).  
All original contributions are clearly marked in code headers. Modified and adapted files are appropriately annotated.  
External figures or methods are cited in the documentation as needed.

> For detailed file authorship and modification status, see `Docs/GEONU_File_Classification.xlsx`.

## License

This project is distributed under the MIT License.
See `LICENSE` for full terms.

## Citation

If you use any result based on this software (either original GEONU or this one) in your publication, please cite the following reference:

> [A Reference Model for the Geoneutrino Signal from the Lithosphere and Upper Mantle](https://agupubs.onlinelibrary.wiley.com/doi/full/10.1029/2019JB018433).  

---
