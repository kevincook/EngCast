var grid;
var ds;

var App = new Ext.App({});

var proxy = new Ext.data.HttpProxy({
  url:'/weeks.js'
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
    {name: 'number'},
    {name: 'startdate', type: 'date', dateFormat: 'Y-m-d\\TH:i:s\\z'},
    {name: 'enddate', type: 'date', dateFormat: 'Y-m-d\\TH:i:s\\z'},
    {name: 'created_at', type: 'date', dateFormat: 'Y-m-d\\TH:i:s\\z'},
    {name: 'updated_at', type: 'date', dateFormat: 'Y-m-d\\TH:i:s\\z'},
    {name: 'day_count'}
  ]
);
  
var writer = new Ext.data.JsonWriter();

var store = new Ext.data.Store({
  id: 'week',
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
    xtype: 'datecolumn',
    header: "Start Date",
    format: 'm/d/y',
    width: 60,
    dataIndex: 'startdate',
    sortable: true,
    editor: {
      xtype: 'datefield',
      allowBlank: false,
      minValue: '01/01/2009',
      minText: "Can't have a date before Jan 2009",
      maxValue: (new Date()).format('m/d/y')
    }
  },
  {
    xtype: 'datecolumn',
    header: "End Date",
    format: 'm/d/y',
    width: 60,
    dataIndex: 'enddate',
    sortable: true,
    renderer: Ext.util.Format.dateRenderer('m/d/Y'),
    editor: {
      xtype: 'datefield',
      allowBlank: false,
      minValue: '01/01/2009',
      minText: "Cant't have a date before Jan 2009",
      maxValue: (new Date()).format('m/d/y')
    }
  },
  {
    header: '# Days',
    width: 60,
    dataIndex: 'day_count',
    sortable: true,
    editor: {
      xtype: 'numberfield',
      allowBlank: false,
      minValue: 0,
      maxValue: 4,
      minText: "Can't have a week with less than zero days",
    }
  }
];

store.load();

Ext.onReady(function() {
  Ext.QuickTips.init();
  
  var editor = new Ext.ux.grid.RowEditor({
    saveText: 'Update'
  });
  
  var userGrid = new Ext.grid.GridPanel({
    renderTo: 'weeks_grid',
    iconCls: 'icon-grid',
    frame: true,
    title: 'Weeks',
    autoScroll: true,
    height: 300,
    store: store,
    plugins: [editor],
    columns: userColumns,
    tbar: [{
      text: 'Add Week',
      iconCls: 'icon-user-add',
      handler: onAdd
    }, '-', {
      text: 'Remove Week',
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
      startdate: '01/01/2009',
      enddate: '01/01/2009',
      day_count: 0
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

