define(['jquery', 'base/js/namespace'], function ($, Jupyter) {
	function load_ipython_extension() {
		if (!Jupyter.notebook_list) return;
		const base_url = Jupyter.notebook_list.base_url;
		$('#tabs').append(
				  '<li>'
				+ `<a href="${base_url}lab?reset">`
				+ '<i class="fa fa-external-link" aria-hidden="true"></i>'
				+ '&nbsp;Switch To JupyterLab'
				+ '</a>'
				+ '</li>');
	};
	return {
		load_ipython_extension : load_ipython_extension,
	};
});
