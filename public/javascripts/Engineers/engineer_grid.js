var grid;
var ds;

var App = new Ext.App({});

var proxy = new Ext.data.HttpProxy({
  url:'/engineers.js'
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
    {name: 'lastname'},
    {name: 'firstname'},
    {name: 'role'},
    {name: 'manager_id'},
    {name: 'created_at'},
    {name: 'updated_at'}
  ]
);
  
var writer = new Ext.data.JsonWriter();

var store = new Ext.data.Store({
  id: 'engineer',
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
    dataIndex:'lastname',
    sortable: true,
    editor: new Ext.form.TextField({})
  },
  { 
    header: "First Name",   
    width: 60, 
    dataIndex:'firstname',
    sortable: true,
    editor: new Ext.form.TextField({})
  },
  { 
    header: "Role",         
    width: 60, 
    dataIndex:'role',
    sortable: true,
    editor: new Ext.form.TextField({})
  }
];

store.load();

Ext.onReady(function() {
  Ext.QuickTips.init();
  
  var editor = new Ext.ux.grid.RowEditor({
    saveText: 'Update'
  });
  
  var userGrid = new Ext.grid.GridPanel({
    renderTo: 'engineer_grid',
    iconCls: 'icon-grid',
    frame: true,
    title: 'Engineers',
    autoScroll: true,
    height: 300,
    store: store,
    plugins: [editor],
    columns: userColumns,
    tbar: [{
      text: 'Add Engineer',
      iconCls: 'icon-user-add',
      handler: onAdd
    }, '-', {
      text: 'Remove Engineer',
      iconCls: 'icon-user-delete',
      handler: onDelete
    }, '-'],
    viewConfig: {
      forceFit: true
    }
  });
  
  function onAdd(btn, ev) {
    var u = new userGrid.store.recordType({
      firstname: 'New',
      lastname: 'Engineer',
      role: 'SW'
    });
    
    editor.stopEditing();
    userGrid.store.insert(0, u);
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

