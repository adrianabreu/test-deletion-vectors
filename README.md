# Test deletion vectors

Deletion vectors are now enabled on the OSS version of Delta Lake (3.1.0). This feature aims to improve performance by minimizing data rewrites when updating small chunks of data. 

## Project Contents
The repository contains:

- A Docker Compose project with Delta 3.1.0 and Spark 3.5.0
- Jupyter notebooks for testing

## Testing

1. Ingesting a set of files from the yellow trip data from 2023 as a Delta table.

2. Comparing the impact of updating a small set of rows with and without deletion vectors

Just run `docker compose up` and test it!

## Conclusions

With deletion vectors enabled, updating 3k rows only added a 6KB bin file along with the new data, compared to 86 MB added without deletion vectors. This represents a significant improvement in storage efficiency.