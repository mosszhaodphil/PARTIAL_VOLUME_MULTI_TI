



function extract_timeseries(file_name, x, y, z)
	
	file_handle = load_nii(strcat(file_name, '.nii.gz'));

	file_matrix = file_handle.img;

	time_series = file_matrix(x, y, z, :);

	time_series = time_series(:);

	dlmwrite('time_series.txt', time_series); % save WM AIF ASL data to a text file

end

