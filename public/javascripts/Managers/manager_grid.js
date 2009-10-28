var grid;
var ds;

var App = new Ext.App({});

var proxy = new Ext.data.HttpProxy({
  url:'/managers.js'
});

var reader = new Ext.data.JsonReader(
  {
    totalProperty: 'total',
    successProperty: 'success',
    idProperty: 'id',
    root: 'rows'
  },
  [
    {name: 'id'},
    {name: 'first_name'},
    {name: 'last_name'},
    {name: 'created_at', type: 'date', dateFormat: 'Y-m-d\\TH:i:s\\z'},
    {name: 'updated_at', type: 'date', dateFormat: 'Y-m-d\\TH:i:s\\z'},
  ]
);
  
var writer = new Ext.data.JsonWriter();

var store = new Ext.data.Store({
  id: 'manager',
  restful: true,
  proxy: proxy,
  reader: reader,
  writer: writer,
  listeners: {
    write: function(store, action, result, response, rs) {
      App.setAlert(response.success, response.message);
    }
  }
});

var userColumns = 
[
  new Ext.grid.RowNumberer(),
  {
    header: "Last Name",
    width: 60,
    dataIndex: 'last_name',
    sortable: true,
  },
  {
    header: "First Name",
    width: 60,
    dataIndex: 'first_name',
    sortable: true,
  }
];

store.load();

Ext.onReady(function() {
  Ext.QuickTips.init();
  
  var editor = new Ext.ux.grid.RowEditor({
    saveText: 'Update'
  });
  
  var userGrid = new Ext.grid.GridPanel({
    renderTo: 'manager_grid',
    iconCls: 'icon-grid',
    frame: true,
    title: 'Managers',
    autoScroll: true,
    height: 300,
    store: store,
    plugins: [editor],
    columns: userColumns,
    tbar: [{
      text: 'Add Manager',
      iconCls: 'icon-user-add',
      handler: onAdd
    }, '-', {
      text: 'Remove Manager',
      iconCls: 'icon-user-delete',
      handler: onDelete
    }, '-'],
    viewConfig: {
      forceFit: true
    }
  });
  
  function onAdd(btn, ev) {
    var u = new userGrid.store.recordType({
      number: 0,
      first_name: 'First',
      last_name: 'Last'
    });
    
    editor.stopEditing();
    userGrid.store.insert(0, u);
    userGrid.getSelectionModel().selectRow(0);
    editor.startEditing(0);
  }
  
  function onDelete(){
    var rec=userGrid.getSelectionModel().getSelected();
    if(!rec){
      return false;
    }
    userGrid.store.remove(rec);
  }
});

