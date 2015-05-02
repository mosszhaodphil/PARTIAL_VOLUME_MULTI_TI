% This function correct all NaN and infinity voxels of a nifty image to zero

function correct_NaN_voxels(file_name)

	% Load nifty file image matrix
	file_extension = '.nii.gz';
	file_handle = load_nii(strcat(file_name, file_extension));
	ma = file_handle.img;

	% Determine the dimension of the matrix
	d = ndims(ma);

	% Correct NaN and infinitive voxels
	if(d == 3)
		[x, y, z] = size(ma);

		for i = 1 : x
			for j = 1 : y
				for k = 1 : z
					if(isnan(ma(i, j, k)) || isinf(ma(i, j, k)))
						ma(i, j, k) = 0;
					end
				end
			end
		end
	end

	if(d == 4)
		[x, y, z, t] = size(ma);

		for i = 1 : x
			for j = 1 : y
				for k = 1 : z
					for l = 1 : t
						if(isnan(ma(i, j, k, l)) || isinf(ma(i, j, k, l)))
							ma(i, j, k, l) = 0;
						end
					end
				end
			end
		end
	end

	% Save the corrected matrix
	file_handle.img = ma;
	save_nii(file_handle, strcat(file_name, file_extension));

end
