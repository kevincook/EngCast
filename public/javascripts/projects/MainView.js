Ext.onReady(function() {
  Ext.QuickTips.init();

  menu = new MenuPanel();
  
  menu.addMenu({
    text: 'Projects',
    url: 'project-node'
  }, false, true);
  
  var viewport = new Ext.Viewport({
    layout: 'border',
    items: [
      new Ext.BoxComponent({
        region:'north',
        el:'header',
        height:32
      }),
      new MenuPanel(),
      new ProjectGrid()
    ]
  })
});