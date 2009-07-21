var grid;
var dataStore;

function render_assignments_grid(){
  dataStore = new Ext.data.Store({
    proxy: new Ext.data.HttpProxy({url:'/assignments.js'}),
    reader: new Ext.data.JsonReader({
      root: 'rows',
      totalProperty: 'total',
    }, [
      {name:'name', mapping:'engineer_displayname'}
    ]),
    remoteSort: false
  });
  
  var columnModel = new Ext.grid.ColumnModel([{
    header:'Name',
    dataIndex:'name',
    width:250
  }]);
  
  columnModel.defaultSortable=true;
  
  grid = new Ext.grid.GridPanel('assignments_grid', {
    ds: dataStore,
    cm: columnModel,
    selModel: new Ext.grid.RowSelectionModel({singleSelct:true}), autoExpandColumn:'name'
  });
  
  grid.render();
  dataStore.load();
  
}