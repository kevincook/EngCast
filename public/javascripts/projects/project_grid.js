var grid;
var ds;

var App = new Ext.App({});

ProjectGrid = function() {
  function getStore() {
    var store = new Ext.data.Store({
      id: 'project',
      restful: true,
      proxy: new Ext.data.HttpProxy({
        url:'/projects.js'
      }),
      reader: new Ext.data.JsonReader(
        {
          totalProperty: 'total',
          successProperty: 'success',
          idProperty: 'id',
          root: 'rows'
        },
        [
        {name: 'id'},
        {name: 'name'},
        {name: 'created_at'},
        {name: 'updated_at'}
        ]
      ),
      writer: new Ext.data.JsonWriter(),
      listeners: {
        write: function(store, action, result, response, rs) {
          App.setAlert(response.success, response.message);
        }
      }
    });
    
    store.load();   
    
    return store; 
  }
  
  function getUserColumns() {
    return [
      new Ext.grid.RowNumberer(),
      { 
        header: "Name",    
        width: 60, 
        dataIndex:'name',
        sortable: true,
        editor: new Ext.form.TextField({})
      }
    ];
  }

  var editor = new Ext.ux.grid.RowEditor({
    saveText: 'Update'
  });

  function onView(){

  }

  function onAdd(btn, ev) {
    var u = new userGrid.store.recordType({
      name: 'New Project'
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

  ProjectGrid.superclass.constructor.call(this, {
    id: 'project',
    region: 'center',
    title: 'Projects',
    autoscroll: true,
    store: getStore(),
    plugins: [editor],
    columns: getUserColumns(),
    tbar: [{
      text: 'Add Project',
      iconCls: 'icon-user-add',
      handler: onAdd
    }, '-', {
      text: 'Remove Project',
      iconCls: 'icon-user-delete',
      handler: onDelete
    }, '-',{
      text: 'View',
      iconCls: 'application_go',
      handler: onView
    }],
    viewConfig : {
      forceFit : true
    }
  });
};

Ext.extend(ProjectGrid, Ext.grid.GridPanel);
