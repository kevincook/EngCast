MenuPanel = function() {
  MenuPanel.superclass.constructor.call(this, {
    id: 'menu-panel',
    region: 'west',
    title: 'Menu',
    split: true,
    width: 225,
    minSize: 175,
    maxSize: 400,
    collapsible: true,
    margins: '0 0 5 5',
    cmargins: '0 5 5 5',
    rootVisible: false,
    lines: false,
    autoScroll: true,
    root: new Ext.tree.TreeNode('My Menu'),
    collapseFirst: false
  });
  
  this.menuItems = this.root.appendChild(
    new Ext.tree.TreeNode({
      text: 'My Menu',
      cls: 'menu-node',
      expanded: true
    })
  )
}

Ext.extend(MenuPanel, Ext.tree.TreePanel, {
  addMenu : function( attrs, inactive, preventAnim ) {
    var exists = this.getNodeById(attrs.url);
    if(exists){
      if(!inactive){
        exists.select();
        exists.ui.highlight();
      }
    }
    Ext.apply(attrs, {
      iconCls: 'menu-node',
      leaf: true,
      cls: 'menu',
      id: attrs.url
    });
    
    var node = new Ext.tree.TreeNode(attrs);
    node = this.menuItems.appendChild(node);
    if(!inactive) {
      if(!preventAnim){
        Ext.fly(node.ui.elNode).slideIn('l', {
          callback: node.select, scope: node, duration: .4
        });
      } else {
        node.select();
      }
    }
    
    return node;
  }
});