

function correct_NaN_voxels(file_name)

	file_extension = '.nii.gz';
	file_handle = load_nii(strcat(file_name, file_extension));
	ma = file_handle.img;

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

	file_handle.img = ma;

	save_nii(file_handle, strcat(file_name, file_extension));

end
