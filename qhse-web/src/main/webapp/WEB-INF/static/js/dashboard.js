Ext.onReady(function() {	
Ext.define('Ext.app.Portal', {
    extend: 'Ext.container.Container',
    renderTo: 'bodyCentre',
    height: 2000,
    width:  550,
    layout: 'fit',

    getTools: function () {
        return [
            {
                xtype: 'tool',
                type: 'gear',
                handler: function (e, target, panelHeader, tool) {
                    var portlet = panelHeader.ownerCt;
                    portlet.setLoading('Loading...');
                    Ext.defer(function () {
                        portlet.setLoading(false);
                    }, 2000);
                }
            }
        ];
    },

    initComponent: function () {
        var content = '<div class="portlet-content"></div>';

        var sitesStore = Ext.create('Ext.data.Store', {
            fields: ['id', 'name'],
            data : sites
        });
        var createYears = function(){
        	var years = [{}];
        	var year = new Date().getFullYear();
        	for(var i=10;i>0;i--){
        		years.push({id: year,name:year})
        		year--;
        	}
        	return years;
        }
        var yearsStore = Ext.create('Ext.data.Store', {
            fields: ['id', 'name'],
            data : createYears()
        });

        var toCfgContainer = function (dashboardCfg) {
            return new Ext.app.ChartContainer({
                dashboardCfg: dashboardCfg
            });
        };

        Ext.apply(this, {
            id: 'app-viewport',
            layout: {
                type: 'border',
                padding: '0 5 5 5' // pad the layout from the window edges
            },
            items: [
                { region: 'center',
                    layout: 'column',
                    autoScroll: true,
                    defaults: {
                        layout: 'anchor',
                        border: false,
                        defaults: {
                            anchor: '100%'
                        }
                    },
                    items: [
                        { columnWidth: 0.50,
                            bodyStyle: 'padding:5px 0 5px 5px',
                            items: Ext.Array.map(leftDashboardColumnItems, toCfgContainer)
                        },
                        { columnWidth: 0.50,
                            bodyStyle: 'padding:5px',
                            items: Ext.Array.map(rightDashboardColumnItems, toCfgContainer)
                        }
                    ]
                },
                { region : 'north',
                    title: 'Criteria',
                    collapsible: true,
                    collapsed: true,
                    height: 100,
                    items: [
                        { xtype: 'form',
                            bodyPadding: 5,
                            frame: true,
                            border: false,
                            items: [{
                                xtype: 'container',
                                anchor: '100%',
                                layout: 'hbox',
                                items:[{
                                    xtype: 'container',
                                    flex: 1,
                                    layout: 'anchor',
                                    items: [{ xtype: 'combo',
                                        multiSelect: true,
                                        store: sitesStore,
                                        displayField: 'name',
                                        valueField: 'id',
                                        anchor: '-20',
                                        fieldLabel: 'Sites',
                                        emptyText: '[all]',
                                        name: 'sites',
                                        editable: false
                                    }]
                                },{
                                    xtype: 'container',
                                    flex: 1,
                                    layout: 'anchor',
                                    items: [{ xtype: 'combo',
                                        store: yearsStore,
                                        displayField: 'name',
                                        valueField: 'id',
                                        queryMode: 'local',
                                        anchor: '-20',
                                        value: new Date().getFullYear(),
                                        fieldLabel: 'Year',
                                        name: 'year'
                                    }]
                                }]
                            }],
                            buttons: [
                                { text: "Reload",
                                    handler: function () {
                                        var filters = this.findParentByType("form").getForm().getValues();
                                        Ext.app.ChartRegistry.baseParams = filters;
                                        Ext.app.ChartRegistry.reloadAll();
                                    }

                                }
                            ],
                            buttonAlign: 'center'
                        }
                    ]
                }
            ]
        });

        this.callParent(arguments);
    },

    showMsg: function (msg) {
        var el = Ext.get('app-msg'),
            msgId = Ext.id();

        this.msgId = msgId;
        el.update(msg).show();

        Ext.defer(this.clearMsg, 3000, this, [msgId]);
    },

    clearMsg: function (msgId) {
        if (msgId === this.msgId) {
            Ext.get('app-msg').hide();
        }
    }
});

Ext.define('Ext.app.ChartContainer', {
    extend: 'Ext.Panel',
    height: 500,
    width: 275,
    layout: 'fit',
    margin: '0 0 5 0',
    dashboardCfg: null,

    initComponent: function () {
        var dashboardCfg = this.dashboardCfg;

        dashboardCfg.valueFieldNames = Ext.Array.map(dashboardCfg.valueFields, function(f) { return f.name });

        this.title = dashboardCfg.title;
        var container = this;
        var chartTypes = {
            PIE: Ext.app.PieChart,
            COLUMN: Ext.app.ColumnChart
        };

        var chartType = chartTypes[dashboardCfg.chartType];
        if (chartType) {
            var chart = new chartType({
                dashboardCfg: dashboardCfg
            });
            chart.getStore().on('beforeload', function () {
            	container.updateTitle(chart);
                this.mask.show();
            }, this);
            chart.getStore().on('load', function () {
                this.mask.hide();
            }, this);

            Ext.apply(this, {
                items: [ chart]
            });

            this.mask = new Ext.LoadMask(this, {msg: "Loading..."});
        }

        this.callParent(arguments);
    },
	updateTitle: function(chart){
		this.setTitle(chart.dashboardCfg.title + ' ' + ((chart.dashboardCfg.constrainedByYear)  ? ('in ' + Ext.app.ChartRegistry.baseParams.year) : ''));
	}

});

Ext.define('Ext.app.ChartRegistry', {

    statics: {
        baseParams: {
        	year: new Date().getFullYear()
        },

        reloadAll: function () {
            var registry = this.registry;
            for (var i = 0; i < registry.length; i++) {
                var chart = registry[i];
                chart.getStore().reload()
            }
        },

        register: function (chart) {
            this.registry.push(chart);
        },

        registry: []
    }

});

Ext.define('Ext.app.BaseChart', {
    extend: 'Ext.chart.Chart',
    animate: true,
    shadow: true,
    height: 500,
    width: 275,
    dashboardCfg: null,

    constructor: function (config) {
        var dashboardCfg = config.dashboardCfg;
        if(dashboardCfg.theme) {
            config.theme = dashboardCfg.theme;
        }

        var fields = [dashboardCfg.categoryField, dashboardCfg.categoryDescriptionField].concat(dashboardCfg.valueFieldNames);

        config.store = Ext.create('Ext.data.JsonStore', {
            fields: fields,
            proxy: {
                type: 'ajax',
                url: contextPath + '/enviro/dashboard/query',
                extraParams: {
                    query: dashboardCfg.name
                },
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            },
            autoLoad: true,
            listeners: {
                beforeload: function(store, operation) {
                    if(!operation.params) {
                        operation.params = {};
                    }
                    Ext.apply(operation.params, Ext.app.ChartRegistry.baseParams);
                }
            }
        });

        // FIXME do other legend positions
        if ("RIGHT" == dashboardCfg.legend) {
            config.legend = {
                position: 'right'
            }
        };

        this.callParent(arguments);

        Ext.app.ChartRegistry.register(this);
    }
});

Ext.define('Ext.app.PieChart', {
    extend: 'Ext.app.BaseChart',

    constructor: function (config) {
        var dashboardCfg = config.dashboardCfg;
        var categoryDescriptionField = dashboardCfg.categoryDescriptionField;
        var valueField = dashboardCfg.valueFieldNames[0];

        config.series = [
            {
                type: 'pie',
                angleField: valueField,
                showInLegend: true,
                tips: {
                    trackMouse: true,
                    width: 300,                    
                    height: 28,
                    renderer: function (storeItem, item) {
                        // calculate and display percentage on hover
                        var total = 0;
                        storeItem.store.each(function (rec) {
                            total += rec.get(valueField);
                        });
                        this.setTitle(storeItem.get(categoryDescriptionField) + ': ' + Math.round(storeItem.get(valueField) / total * 100) + '%');
                    }
                },
                highlight: {
                    segment: {
                        margin: 20
                    }
                },
                label: {
                    field: categoryDescriptionField
                }
            }
        ];

        this.callParent(arguments);
    }
});

Ext.define('Ext.app.ColumnChart', {
    extend: 'Ext.app.BaseChart',

    constructor: function (config) {
        var dashboardCfg = config.dashboardCfg;

        var numeric = { type: 'Numeric',
            position: 'left',
            fields: dashboardCfg.valueFieldNames,
            title: dashboardCfg.valueAxisTitle,
            grid: true,
            minimum: 0
        };

        var category = { type: 'Category',
            position: 'bottom',
            fields: [dashboardCfg.categoryField],
            title: dashboardCfg.categoryAxisTitle
        };

        if(dashboardCfg.hideCategoryAxisLabels === true) {
            category.label = {
                renderer: function() {
                    return "";
                }
            }
        }

        config.axes = [numeric, category];

        var columnCfg = { type: 'column',
            axis: 'left',
            gutter: 80,
            xField: dashboardCfg.categoryField,
            yField: dashboardCfg.valueFieldNames,
            stacked: true,
            tips: {
                trackMouse: true,
                width: 175,
                height: 28,
                renderer: function (storeItem, item) {
                    var elements = [];
                    for (var i = 0; i < dashboardCfg.valueFields.length; i++) {
                        var field = dashboardCfg.valueFields[i];
                        var value = storeItem.get(field.name);
                        elements.push(field.label + ": " + value);
                    };
                    this.setTitle(elements.join(", "));
                }
            }
        };

        var rendererName = dashboardCfg.columnRenderer;
        var renderer = rendererName ? ss.chart.columnRenderers[rendererName] : null;
        if (renderer) {
            columnCfg.renderer = renderer;
        }


        config.series = [columnCfg];

        this.callParent(arguments);
    }
});

Ext.define("ss.chart.columnRenderers", {
    statics: {

        riskAssessment: function (sprite, record, attr, index, store) {
            if(!record) {
                return attr;
            }
            var color = record.get('color');
            var rgb = 'rgb(250, 40, 40)';
            if (color == "1green") {
                rgb = 'rgb(100, 255, 100)';
            } else if (color == "2amber") {
                rgb = 'rgb(255, 180, 80)';
            }
            return Ext.apply(attr, {
                fill: rgb
            });
        }

    }
});

Ext.define('Ext.chart.theme.DataBreaches', {
    extend: 'Ext.chart.theme.Base',

    constructor: function (config) {
        this.callParent([Ext.apply({
            colors: [
                '#FA2828', 
                '#FFB450', 
                '#98A148'	
            ]
        }, config)]);
    }
});

Ext.define('Ext.chart.theme.Audit', {
    extend: 'Ext.chart.theme.Base',

    constructor: function (config) {
        this.callParent([Ext.apply({
            colors: [
                '#FFB450',
                '#FA2828'
            ]
        }, config)]);
    }
});
});
