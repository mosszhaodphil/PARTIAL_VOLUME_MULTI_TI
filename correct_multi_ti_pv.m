


function correct_multi_ti_pv(gm_file, wm_file, mask_file, kernel_size)

	data_file_base = 'asldata_ti_';

	% total 78 TI
	num_ti = 78;

	for i = 0 : (num_ti - 1)
		current_file = strcat(data_file_base, sprintf('%03d', i));

		% Perform partial volume correction (Asllani's linear regression method)
		pv_correct(current_file, gm_file, wm_file, mask_file, kernel_size);

		display(strcat(current_file, ' completed'));
	end

end
