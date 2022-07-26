function getGridOneKey(grid_area,key){
		var rows = $('#'+grid_area).datagrid('getSelections');
			if(rows.length == 1 )
			{
				return rows[0][key];
				
			}else {
				$.messager.alert('提示','请选择一条数据');
				return ;
			}
		}
		
function getGridSomeKey(grid_area,key){
		var rows = $('#'+grid_area).datagrid('getSelections');
		var id = [];
			if(rows.length > 0 )
			{
				for(var i = 0 ; i< rows.length ; i ++){
				id.push(rows[i][key]);
				}
				return id.join(",");
			}else {
				$.messager.alert('提示','请选择数据');
				return ;
			}
		}