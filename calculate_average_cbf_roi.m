% This function performs ROI analysis of partial volume corrected data
% The voxels on pv image is divided into different bins according to their intensity (10-20%, 20-30%, ...)
% For each bin, we calculate the average CBF
% Input parameters:
% Partail volume nifty file name (without extension)
% Data nifty file name (without extension)
% Output:
% Text file containing the average CBF of each bin

function [] = calculate_average_cbf_roi(file_pv, file_data)

	file_output = 'average_cbf.txt';

	file_extension = '.nii.gz';

	% Load input files
	handle_pv   = load_nii(strcat(file_pv, file_extension));
	handle_data = load_nii(strcat(file_data, file_extension));
	matrix_pv   = handle_pv.img;
	matrix_data = handle_data.img;

	[x, y, z] = size(matrix_data);

	bin     = zeros(9, 1);
	count   = zeros(9, 1);
	average = zeros(9, 1);

	l = 0;

	for i = 1 : x
		for j = 1 : y
			for k = 1 : z

				% Continue to next iteration if there is negative value
<<<<<<< HEAD
				if(matrix_data(i, j, k) <= 0 || isnan(matrix_data(i, j, k)) || isinf(matrix_data(i, j, k)))
=======
				if(matrix_data(i, j, k) < 0)
					continue;
				end

				% Continue to next iteration if the value is too high
				if(matrix_data(i, j, k) >= 500)
>>>>>>> origin/master
					continue;
				end

				% Check probability of current PV voxel,and assign corresponding data voxel to appropriate bins
				pv_value = matrix_pv(i, j, k) * 100;

<<<<<<< HEAD
=======
				% Continue to next iteration if pv is less or equal to 10%
>>>>>>> origin/master
				if(pv_value < 10)
					continue;
				end

				if(pv_value >= 10 && pv_value < 20)
					bin(1, 1) = bin(1, 1) + matrix_data(i, j, k);
					count(1, 1) = count(1, 1) + 1;

				end
				if(pv_value >= 20 && pv_value < 30)
					bin(2, 1) = bin(2, 1) + matrix_data(i, j, k);
					count(2, 1) = count(2, 1) + 1;

				end
				if(pv_value >= 30 && pv_value < 40)
					bin(3, 1) = bin(3, 1) + matrix_data(i, j, k);
					count(3, 1) = count(3, 1) + 1;
				end					
				if(pv_value >= 40 && pv_value < 50)
					bin(4, 1) = bin(4, 1) + matrix_data(i, j, k);
					count(4, 1) = count(4, 1) + 1;
				end
				if(pv_value >= 50 && pv_value < 60)
					bin(5, 1) = bin(5, 1) + matrix_data(i, j, k);
					count(5, 1) = count(5, 1) + 1;
				end
				if(pv_value >= 60 && pv_value < 70)
					bin(6, 1) = bin(6, 1) + matrix_data(i, j, k);
					count(6, 1) = count(6, 1) + 1;
				end
				if(pv_value >= 70 && pv_value < 80)
					bin(7, 1) = bin(7, 1) + matrix_data(i, j, k);
					count(7, 1) = count(7, 1) + 1;
				end
				if(pv_value >= 80 && pv_value < 90)
					bin(8, 1) = bin(8, 1) + matrix_data(i, j, k);
					count(8, 1) = count(8, 1) + 1;
				end
				if(pv_value >= 90 && pv_value <= 100)
					bin(9, 1) = bin(9, 1) + matrix_data(i, j, k);
					count(9, 1) = count(9, 1) + 1;
				end

			end
		end
	end

	% Calculate the average value of each bin
	average = bin ./ count;
	bin
	count

	dlmwrite(file_output, average); % save noncrushed ASL data to a text file

end

