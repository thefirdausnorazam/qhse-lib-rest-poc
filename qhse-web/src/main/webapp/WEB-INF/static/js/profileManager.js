Ext.override(Ext.form.Action.Load, {
  success : function(response){
    var result = this.processResponse(response);
    // default the data reference to the result reference 
    if (!result.data) {
      result.data = result;
    }
    if (!result.hasOwnProperty("success") && result.hasOwnProperty("data") && result.data.hasOwnProperty("id")) {
      //successful but missing success property
      result.success = true;
    }
    if(result === true || !result.success || !result.data){
        this.failureType = Ext.form.Action.LOAD_FAILURE;
        this.form.afterAction(this, false);
        return;
    }
    this.form.clearInvalid();
    this.form.setValues(result.data);
    this.form.afterAction(this, true);
  }
});

Ext.form.Action.Submit.originalHandleResponse = Ext.form.Action.Submit.prototype.handleResponse;
Ext.override(Ext.form.Action.Submit, {
  handleResponse : function(response){
    // trap html exception traces from fileupload submits
    var responseText = response.responseText;
    if (responseText && responseText.trim().charAt(0) === '<') {
      return { success: false };
    }
    return Ext.form.Action.Submit.originalHandleResponse.call(this, response);
  }
});

Ext.Ajax.on('requestcomplete', function(conn, response, options) {
  var responseText = response.responseText;
  if (responseText && responseText.indexOf("LogInPage.html") >= 0) {
    top.location.reload(); 
  }
});

Ext.Ajax.on('requestexception', function(conn, response, options) {
  Ext.Msg.show({
    title: 'Error',
    msg: response.responseText || 'Unknown system error',
    minWidth: 600,
    buttons: Ext.MessageBox.OK,
    icon: Ext.MessageBox.ERROR
 });
});

Ext.onReady(function() {
  Ext.MessageBox.getDialog().on({
    'beforeshow': function(win) {
    var maxHeight = 500;
    var messageEl = win.body.first();
    if(messageEl.getHeight() > maxHeight) {
      messageEl.setHeight(maxHeight);
      messageEl.applyStyles("overflow-y: auto;");  
    }
  },
  'hide': function(win) {
    var messageEl = win.body.first();
    messageEl.applyStyles("height: auto");  
  }
  });
});

Ext.Panel.prototype.buttonAlign = 'center';

Ext.namespace('scansol.docs');

scansol.docs.Util = {
  manageLinks: function(holderName) {
    var url = contextPath + '/doclink/holderEdit.htm?holderName=' + holderName;
    var w = 1000;
    var h = 550;
    var x = (screen.height-h)/2;
    var y = (screen.width-w)/2;
    var att="toolbar=no,directories=no,location=no,status=no,menubar=no,resizable=yes,width="+w+",height="+h+",top="+x+",left="+y + ", scrollbars=yes";
    var win = window.open(url, "links", att);
    win.focus();
  }
};

Ext.namespace('scansol.law');

scansol.FormPanel = Ext.extend(Ext.form.FormPanel, {
  border: true,
  bodyCssClass: 'ss-form-border',
  disableButtonsOnParent: false,
  
  initComponent: function() {
    if(this.initialConfig && this.url) {
      this.initialConfig.url = this.url; // add url to initialConfig so it is applied to the BasicForm
    }
    scansol.FormPanel.superclass.initComponent.call(this);
    this.addEvents("successfulSubmit");
    this.on('actioncomplete', function(form, action) {
      this.disableButtons(false);
      if (action.type == 'submit') {
        this.fireEvent('successfulSubmit', form, action);
      }
    });
    this.on('actionfailed', function(form, action) {
      this.disableButtons(false);
      if (action.type == 'submit' && action.response) {
        var msg = action.response.responseText;
        if (action.result && action.result.errors) {
          msg = '';
          var errors = action.result.errors;
          for(var i = 0, len = errors.length; i < len; i++) {
            var r = errors[i];
            msg += r.msg + '<br/><br/>';
          }
        }
        Ext.Msg.show({
          title: '',
          msg: msg,
          minWidth: 400,
          buttons: Ext.MessageBox.OK,
          icon: Ext.MessageBox.INFO
       });
      }
    });
    this.on('beforeaction', function(form, action) {
      this.disableButtons(true);
    });
  },
  disableButtons: function(disabled) {
    if(this.disableButtonsOnParent === true) {
      Ext.each(this.ownerCt.buttons, function(button) {
        button.setDisabled(disabled);
      });
    }
  }
});
Ext.reg("scansol.FormPanel", scansol.FormPanel);

scansol.gridRenderers = {
  booleanToCheckbox: function(value) {
    var name = value === true ? 'on' : 'off';
    return '<span class="ss-checkbox-' + name + '">&nbsp;</span>';
  }
};

scansol.law.questionGroupDataStore = new Ext.data.Store({
  proxy: new Ext.data.HttpProxy({
    url: contextPath + '/law/questionnaire'
  }),
  reader: new Ext.data.JsonReader({
    root: 'groups', 
    fields: ['id', 'code', 'questions']
  }),
  listeners: {
    load: function(store, records) {
      var questionsByCode = {};
      Ext.each(records, function(record) {
        Ext.each(record.get('questions'), function(question) {
          questionsByCode[question.code] = question;
          if (question.parentQuestionCode) {
            question.parentQuestion = questionsByCode[question.parentQuestionCode];
          }
        });
      });
    }
  }
});
scansol.law.questionGroupDataStore.load();

scansol.law.profileTypeDataStore = new Ext.data.Store({
  autoLoad: true,
  proxy: new Ext.data.HttpProxy({
    url: contextPath + '/law/profileType/list'
  }),
  reader: new Ext.data.JsonReader({
    root: 'values', 
    fields: ['id', 'name']
  })
});

// ENV-127 on hold
//scansol.law.siteDataStore = new Ext.data.Store({
//  autoLoad: true,
//  proxy: new Ext.data.HttpProxy({
//    url: contextPath + '/law/site/list'
//  }),
//  reader: new Ext.data.JsonReader({
//    root: 'values', 
//    fields: ['id', 'name']
//  })
//});
//
//scansol.law.managementProgrammeDataStore = new Ext.data.Store({
//  autoLoad: true,
//  proxy: new Ext.data.HttpProxy({
//    url: contextPath + '/law/managementProgramme/list'
//  }),
//  reader: new Ext.data.JsonReader({
//    root: 'values', 
//    fields: ['id', 'name', 'site']
//  }),
//  listeners: {
//    load: function(store, records, options) {
//      // need to replace newlines in name as combo boxes break if there are any at the end of the text
//      Ext.each(records, function(record) {
//        record.set('name', record.get('name').replace(/\n/g, ' '));
//      });
//    }
//  }
//  
//});

scansol.law.profileStateDataStore = new Ext.data.Store({
  autoLoad: true,
  proxy: new Ext.data.HttpProxy({
    url: contextPath + '/law/profileState/list'
  }),
  reader: new Ext.data.JsonReader({
    root: 'values', 
    fields: ['id', 'name']
  })
});

scansol.law.profileOwnerDataStore = new Ext.data.Store({
  autoLoad: true,
  proxy: new Ext.data.HttpProxy({
    url: contextPath + '/law/profileOwner/list'
  }),
  reader: new Ext.data.JsonReader({
    root: 'values', 
    fields: ['id', 'name']
  })
});


scansol.law.ProfileQuestionnaireGroupPanel = Ext.extend(Ext.Panel, {
  groupCodes: null,
  autoScroll: true,
  layout: 'form',
  forceLayout: true,
  anchor: '90%',
  bodyStyle: 'padding:5px 1px 0; overflow-y: scroll;',//before it was  5px 5px 0;
  bodyCssClass: 'ss-leg',

  onRender : function(container, position) {
    scansol.law.ProfileQuestionnaireGroupPanel.superclass.onRender.call(this, container, position);

    this.multichoicePanelTemplate.compile();
    
    Ext.each(this.groupCodes, function(groupCode) {
      var questionGroupIndex = scansol.law.questionGroupDataStore.find('code', groupCode);
      var questionGroup = scansol.law.questionGroupDataStore.getAt(questionGroupIndex).json;
      var hasMultichoice = false;
      Ext.each(questionGroup.questions, function(question) {
        if(question.type === "MULTICHOICE") {
          hasMultichoice = true;
        }
      }, this);
      var targetContainer = hasMultichoice ? this : this.add(new Ext.form.FieldSet({
        autoHeight: true,
        bodyStyle: 'padding:5px 5px 0;'
      }));
      Ext.each(questionGroup.questions, function(question) {
        this.addQuestion(question, targetContainer);
      }, this);
    }, this);
  },
  addQuestion: function(question, parentContainer) {
    if("icd_common.business.annual_sales_turnover" === question.code) {
      //this question is part of a multichoice group and needs a field set for itself
      parentContainer = parentContainer.add(new Ext.form.FieldSet({
        autoHeight: true,
        bodyStyle: 'padding:5px 5px 0;'
      }));      
    }
    var questionComponent = null;
    var fieldWidth = 400;
    switch(question.type) {
    case "TEXT":
      questionComponent = new Ext.form.TextField({
        name: question.code,
        fieldLabel: question.name,
        width: fieldWidth
      });
      break;
    case "TEXTAREA":
      questionComponent = new Ext.form.TextArea({
        name: question.code,
        fieldLabel: question.name,
        width: fieldWidth
      });
      break;
    case "CHOICE":
      var parentQuestionCode = null;
      questionComponent = new Ext.form.ComboBox({
        mode: 'local',
        triggerAction: 'all',
        editable: false,
        valueField: 'id',
        displayField: 'name',
        store: new Ext.data.JsonStore({
          fields: ['id', 'name', 'parent'],
          data: question.choices,
          autoDestroy: true
        }),
        hiddenName: question.code,
        fieldLabel: question.name,
        width: fieldWidth
      });
      if(question.parentQuestion) {
        questionComponent.lastQuery = ''; // hack to get store.filter to work
        var parentQuestionField = parentContainer.find('hiddenName', question.parentQuestion.code)[0];
        questionComponent.setValue(null);
        parentQuestionField.on('valid', function() {
          var parentValue = parentQuestionField.hiddenField.value;
          if(typeof questionComponent.lastParentValue == "undefined" &&  question.name == "REGION"){
          questionComponent.setDisabled(true);
          }else if((questionComponent.lastParentValue != parentValue) &&  question.name == "REGION"){
        	questionComponent.setDisabled(false);
          }
          if(questionComponent.lastParentValue != parentValue) {
            questionComponent.setValue(null);
            questionComponent.lastParentValue = parentValue;
          }
          questionComponent.getStore().filterBy(function(record) {
            return record.get('parent') == parentValue;
          });
        });
      }
      break;
    case "MULTICHOICE":
      this.buildMultichoicePanel(question);
      break;
    }
    if(questionComponent) {
      questionComponent.on('change', function() {
        scansol.law.profileDirty = true;
      });
      parentContainer.add(questionComponent);
      
    }
  },
  buildMultichoicePanel: function(question, parentChoice) {
    if(question.parentQuestion && !parentChoice) {
      var parentChoices = question.parentQuestion.choices;
      var parentChoicesLength = parentChoices.length;
      for (var i = 0; i < parentChoicesLength; i++) {
        this.buildMultichoicePanel(question, parentChoices[i]);
      }
      return;
    }

    var allChoices = question.choices;
    var allChoicesLength = allChoices.length;
    var filteredChoices = [];
    for (i = 0; i < allChoicesLength; i++) {
      var choice = allChoices[i];
      if (!parentChoice || parentChoice.id === choice.parent) {
        choice.questionCode = question.code; // populate reference back to parent needed for xtemplate rendering
        filteredChoices.push(choice);
      }
    }
    
    if(filteredChoices.length === 0) {
      return;
    }

    // manually build as xtemplate is too slow in ie6
    var content = [];
    content.push('<table width="99%">');
    content.push('<tr>');
    for(col=0; col<2; col++) {
      content.push('<td class="ss-pmgr-checkbox" width="50%">');
      for (i=0, l=filteredChoices.length; i < l; i++) {
        if(i % 2 === col) {
          var fc = filteredChoices[i];
          content.push('<label class="x-form-cb-label"><input type="checkbox" name="', fc.questionCode,'" value="',fc.id,'" autocomplete="off"/><span>',fc.name,'</span></label><br />');
        }
      }
      content.push('</td>');
    }
    content.push('</tr>');
    content.push('</table>');
    
    var multichoicePanel = this.add(new Ext.form.FieldSet({
      title: question.name + (parentChoice ? " - " + parentChoice.name : ""),
      id: parentChoice ? "multichoicePanel" + parentChoice.id : null,
      hidden: (parentChoice ? true : false),
      html: content.join(''),
      listeners: {
        'afterrender': function(panel) {
          var inputElemets = panel.getEl().select('input');
          inputElemets.on('click', function() {
            scansol.law.ProfileQuestionnaireGroupPanel.multichoiceCheckboxClick(this);
          });
        }      
      }
    }));
    if (parentChoice) {
      parentChoice.childPanel = multichoicePanel;
    }
  },
  multichoicePanelTemplate: new Ext.XTemplate(
      '<table width="95%">',
        '<tr>',
          '<td class="ss-pmgr-checkbox" width="50%">',
            '<tpl for=".">',
               '<tpl if="xindex % 2 == 0">',
                 '<label class="x-form-cb-label"><input type="checkbox" name="{questionCode}" value="{id}" autocomplete="off"/>{name}</label>',
               '</tpl>',
            '</tpl>',
          '</td>',
          '<td class="ss-pmgr-checkbox" width="50%">',
            '<tpl for=".">',
               '<tpl if="xindex % 2 == 1">',
                 '<label class="x-form-cb-label"><input type="checkbox" name="{questionCode}" value="{id}" autocomplete="off"/>{name}</label>',
               '</tpl>',
            '</tpl>',
            '</td>',
        '</tr>',
      '</table>'),
  multichoiceCheckboxChecked: function(checkbox, checked) {
    var childPanel = checkbox.choice.childPanel;
    if(childPanel) {
      childPanel.setVisible(checked);
      this.doLayout();
    }
  },
  setAnswers: function(answers, form) {
    if(!this.rendered) {
      this.on('afterrender', function() {
        this.setAnswers(answers, form);
      }, null, { delay: 100 }); //delay to allow nested combo values to set correctly
      return;
    }

    form.items.each(function(item) {
      if(this.findById(item.getId())) {  // => field in this panel
        var name = item.getName();
        item.setValue(answers[name]);
        delete answers[name];
      }
    }, this);
    var matchedAnswerNames = []
    Ext.each(this.body.query("INPUT[type=checkbox]"), function(item) {
      var name = item.name;
      var answer = answers[item.name];
      if(answer) {
        item.checked = answer.indexOf(item.value) >= 0;
        scansol.law.ProfileQuestionnaireGroupPanel.multichoiceCheckboxClick(item, true);
      }
      matchedAnswerNames.push(name);
    });
    Ext.each(matchedAnswerNames, function(name) {
      delete answers[name];
    });  
  }
});

scansol.law.ProfileQuestionnaireGroupPanel.multichoiceCheckboxClick = function(cb, skipDirtyCheck) {
  var childPanel = Ext.ComponentMgr.get("multichoicePanel" + cb.value);
  if(childPanel) {
    var checked = cb.checked;
    childPanel.setVisible(checked);
    if(checked === false) {
      Ext.each(childPanel.el.query("INPUT[type=checkbox]"), function(item) {
        item.checked = false;
      });
    }
  }
  if(skipDirtyCheck !== true) {
    scansol.law.profileDirty = true;
  }
};


scansol.law.ProfileGeneralQuestionsPanel = Ext.extend(scansol.law.ProfileQuestionnaireGroupPanel, {
  onRender : function(container, position) {
    scansol.law.ProfileGeneralQuestionsPanel.superclass.onRender.call(this, container, position);
    
    var fieldWidth = 400;
    
 // ENV-127 on hold
//    var siteCombo = new Ext.form.ComboBox({
//      mode: 'local',
//      triggerAction: 'all', 
//      editable: false,
//      store: scansol.law.siteDataStore,
//      displayField: 'name',
//      valueField: 'id',
//      fieldLabel: 'Site',
//      hiddenName: 'site',
//      width: fieldWidth
//    });
//    var managementProgrammeCombo = new Ext.form.ComboBox({
//      mode: 'local',
//      triggerAction: 'all',
//      editable: false,
//      valueField: 'id',
//      displayField: 'name',
//      store: scansol.law.managementProgrammeDataStore,
//      hiddenName: 'managementProgrammeId',
//      fieldLabel: 'Management Programme',
//      width: fieldWidth
//    });
//    var filterManagementProgrammes = function() {
//      var site = siteCombo.hiddenField.value;
//      if(managementProgrammeCombo.lastSite != site) {
//        managementProgrammeCombo.setValue(null);
//        managementProgrammeCombo.lastSite = site;
//      }
//      managementProgrammeCombo.getStore().filterBy(function(record) {
//        return record.get('site') == site;
//      });
//    };
//    siteCombo.on('valid', filterManagementProgrammes);
//    managementProgrammeCombo.on('expand', filterManagementProgrammes);
    
    this.insert(0, { 
      xtype:'fieldset',
      autoHeight:true,
      bodyStyle: 'padding:5px 5px 0;',
      defaults: {width: fieldWidth},
      items :[
        { xtype: 'combo',
          mode: 'local',
          triggerAction: 'all', 
          editable: false,
          store: scansol.law.profileTypeDataStore,
          displayField: 'name',
          valueField: 'id',
          fieldLabel: SCANNELL_TRANSLATIONS.profileTypeGQPanel,
          hiddenName: 'registerType',
          listeners: {
            change: function() {
              scansol.law.profileDirty = true;          
            }
          }
        },
        { xtype: 'textfield',
          fieldLabel: SCANNELL_TRANSLATIONS.profileNameGQPanel,
          emptyText: SCANNELL_TRANSLATIONS.enterNameGQPanel,
          name: 'name'
        },
        { xtype: 'textarea',
          fieldLabel: SCANNELL_TRANSLATIONS.profileDescriptionGQPanel,
          emptyText: SCANNELL_TRANSLATIONS.enterDescriptionGQPanel,
          name: 'description'
        },
        { xtype: 'hidden',
          name: 'id'
        },
        { xtype: 'hidden',
          name: 'version'
        }
// ENV-127 on hold
//        siteCombo,
//        managementProgrammeCombo
      ]
    });
    
    this.add({ 
      xtype:'fieldset',
      autoHeight:true,
      defaults: {width: 400},
      bodyStyle: 'padding:5px 5px 0;',
      items: [
        { xtype: 'combo',
          mode: 'local',
          triggerAction: 'all',
          editable: false,
          store: scansol.law.profileOwnerDataStore,
          displayField: 'name',
          valueField: 'id',
          fieldLabel: SCANNELL_TRANSLATIONS.primaryOwnerGQPanel,
          hiddenName: 'effectiveOwner'
        }
      ]
    });
    
    this.add({ 
        xtype:'fieldset',
        autoHeight:true,
        defaults: {width: 400},
        bodyStyle: 'padding:5px 5px 0;',
        items: [
          { xtype: 'combo',
            mode: 'local',
            triggerAction: 'all',
            editable: false,
            store: scansol.law.profileOwnerDataStore,
            displayField: 'name',
            valueField: 'id',
            fieldLabel: SCANNELL_TRANSLATIONS.secondaryOwnerGQPanel,
            hiddenName: 'owner'
          }
        ]
      });
    
    if(ss_cgen === true) {
      this.add({ 
    	xtype:'fieldset',
    	autoHeight:true,
    	defaults: {width: 400},
    	bodyStyle: 'padding:5px 5px 0;',
    	items: [
    	  { xtype: 'textfield',
    		name: 'publicationReference',
    		fieldLabel: 'Publication Reference'
          }
    	]
      });
    }

  }
});

scansol.law.ProfileQuestionnaireChecklistsGrid = Ext.extend(Ext.Panel, {
  title: SCANNELL_TRANSLATIONS.checklistsTabPanel,
  autoScroll: true,
  bodyCssClass: 'ss-leg',
  bodyStyle: 'padding:5px 0px 0px; overflow-y: scroll;',//this line was included because in some resolution is mising part of the page
  onRender : function(container, position) {
    scansol.law.ProfileQuestionnaireChecklistsGrid.superclass.onRender.call(this, container, position);
    this.body.on('click', function(evt) {
      var el = Ext.fly(evt.getTarget());
      if (el.is('a')) { 
        var dialog = new scansol.law.ProfileChecklistRelevancyEditWindow({
          checklist: {
            id: el.getAttribute('cid'),
            name: el.getAttribute('checklistname')
          },
          profile: this.profile,
          listeners: {
            scope: this, 
            close: function() {
              this.refresh(this.profile);
            }
          }
        });
        dialog.show();
      }
    }, this);
  },
  refresh: function(profile) {
    this.profile = profile;
    Ext.Ajax.request({
      url: contextPath + '/law/profileManagerChecklists.htmf',
      params: {
        profileId: profile.id
      },
      scope: this,
      success: function(response) {
        this.body.update(response.responseText);
      },
      failure: function(response) {
        this.el.unmask();
      }
    });
  }
});


scansol.law.ProfileQuestionnaireFormPanel = Ext.extend(scansol.FormPanel, {
  layout: 'fit',
  labelWidth: 200,
  labelAlign: 'right',
  url: contextPath + '/law/answer',
  profile: null,
  jumpToChecklistsTabOnOpen: false,
  inactivityWarningTime: 5 * 60 * 1000, // 5 mins
  
  initComponent: function () {
    scansol.law.ProfileQuestionnaireFormPanel.superclass.initComponent.call(this);
  
    scansol.law.profileDirty = false;
    
    this.tabPanel = this.add(new Ext.TabPanel({
      activeTab: 0,
//      deferredRender: false,
      items: [
        new scansol.law.ProfileGeneralQuestionsPanel({
          title: SCANNELL_TRANSLATIONS.generalTabPanel,
          groupCodes: ["legal.profiler.general"],
          listeners: {
            scope: this,
            afterrender: function(panel) {
              this.getForm().findField('registerType').on('select', function(combo, record) {
                this.registerTypeChanged(combo.getValue());
              }, this);
            }
          }
        }),      
        new scansol.law.ProfileQuestionnaireGroupPanel({
          title: SCANNELL_TRANSLATIONS.businessTabPanel,
          groupCodes: ["icd_common.location", "icd_common.business"]
        }),
        new scansol.law.ProfileQuestionnaireGroupPanel({
          title: SCANNELL_TRANSLATIONS.materialsTabPanel,
          groupCodes: ["icd_common.dangerous_substances"]
        }),
        new scansol.law.ProfileQuestionnaireGroupPanel({
          title: SCANNELL_TRANSLATIONS.environmentTabPanel,
          disableRegisterType: 2, //HEALTH_SAFETY
          groupCodes: ["icd_env.emissions", "icd_env.impacts", "icd_env.equipment", "icd_env.activities", "icd_env.waste"]
        }),
        new scansol.law.ProfileQuestionnaireGroupPanel({
          title: SCANNELL_TRANSLATIONS.safetyTabPanel,
          disableRegisterType: 1, //ENVIRONMENT
          groupCodes: ["icd_hs.activities"]
        })
      ]
    }));

    this.checklistsGrid = this.tabPanel.add(new scansol.law.ProfileQuestionnaireChecklistsGrid({
      listeners: {
        scope: this,
        beforeshow: function() {
          if(this.checklistsGrid.body) {
            this.checklistsGrid.body.update('');
          }
        },
        activate: {
          delay: 100, // delay to allow change events to fire before tab activate
          fn: function() {
            if(this.profile && this.profile.actualContentVersion === this.profile.latestContentVersion && scansol.law.profileDirty !== true) {
              this.checklistsGrid.refresh(this.profile);
              return;
            }
            this.getForm().submit({
              scope: this,
              success: function(form, action) {
                var profile = action.result;
                if(profile.actualContentVersion < profile.latestContentVersion && this.profileVersionAcknowleged !== true) {
                  this.profileVersionAcknowleged = true;
                  Ext.Msg.show({
                    title: 'Content Updated',
                    msg: 'The latest update to legislation has been incorporated into this Profile. Click on the Finish button to complete the update. To see new or changed legislation close the Profile window and view New Legislation (for latest changes) and Change Record (for earlier changes) in the Law module.',
                    buttons: Ext.MessageBox.OK,
                    icon: Ext.MessageBox.WARNING
                  });                
                }
                this.checklistsGrid.refresh(profile);
              }
            });
          }
        }
      }
    }));
    
    this.on({
      scope: this,
      beforeaction: function() {
        this.cancelInactivityWarning();
        this.el.mask(SCANNELL_TRANSLATIONS.processingProf);
      }, 
      actioncomplete: function(form, action) {
        this.el.unmask();
        if (action.type == 'submit') {
          if (action.options && action.options.params && action.options.params.finish === true) {
            return;
          }
          var profile = action.result;
          this.getForm().findField("id").setValue(profile.id);
          this.getForm().findField("version").setValue(profile.version);
          if (action.options && action.options.params && action.options.params.returnContent === true) {
            this.checklistsGrid.profile = profile;
          }
          this.resetInactivityWarning();
        }
      }, 
      actionfailed: function() {
        this.el.unmask();
      }
    });
    
    
    if(this.profile) {
      this.on('afterrender', function() {
        this.el.mask("loading...");
        Ext.Ajax.request({
          url: contextPath + '/law/answers',
          params: {
            id: this.profile.id,
            version: this.profile.version
          },
          scope: this,
          success: function(response) {
            this.el.unmask();
            this.setAnswers(Ext.decode(response.responseText));
            if(this.jumpToChecklistsTabOnOpen === true) {
              this.tabPanel.activate(this.checklistsGrid)
            }
          },
          failure: function(response) {
            this.el.unmask();
          }
        });
      }, this);
    }
    
    this.resetInactivityWarning();
    
    this.on('beforedestroy', this.cancelInactivityWarning);
  },

  inactivityWarning: function() {
    this.resetInactivityWarning();
    window.focus();
    Ext.Msg.alert(SCANNELL_TRANSLATIONS.warning, SCANNELL_TRANSLATIONS.someTime);
  },
  
  resetInactivityWarning: function() {
    this.cancelInactivityWarning();
    this.inactivityWarningId = this.inactivityWarning.defer(this.inactivityWarningTime, this);
//    console.log("resetInactivityWarning: " + this.inactivityWarningId);
  },
  
  cancelInactivityWarning: function() {
    if(this.inactivityWarningId) {
      clearTimeout(this.inactivityWarningId);
//      console.log("cancelInactivityWarning: " + this.inactivityWarningId);
    }
  },
  
  setAnswers: function(answers) {
    var form = this.getForm(); 
    form.baseParams = answers; // store current values as baseParams, values will be removed when their panel gets rendered.
    this.registerTypeChanged(answers.registerType);
    this.tabPanel.items.each(function(item) {
      if (item.setAnswers) {
        item.setAnswers(answers, form);
      }
    });
  },
  registerTypeChanged: function(registerType) {
    this.tabPanel.items.each(function(tab) {
      if (tab.disableRegisterType) {
        tab.setDisabled(tab.disableRegisterType === registerType)
      }
    });
  }
});

    
scansol.law.ProfileQuestionnaireWindow = Ext.extend(Ext.Window, {
  modal: true,
  width: 900,
  height: 500,
  layout: 'fit',
  constrain: true,
  maximized: true,
  profile: null,
  jumpToChecklistsTabOnOpen: false,
  
  initComponent: function() {
    scansol.law.ProfileQuestionnaireWindow.superclass.initComponent.call(this);
    this.setTitle(this.profile ? 'Edit Profile ' + this.profile.name : SCANNELL_TRANSLATIONS.newProfile);
    var formPanel = this.add(new scansol.law.ProfileQuestionnaireFormPanel({
      profile: this.profile,
      jumpToChecklistsTabOnOpen: this.jumpToChecklistsTabOnOpen,
      listeners: {
        scope: this,
        successfulSubmit: function(form, action) {
          if (action.options && action.options.params && action.options.params.finish === true) {
            this.close();
          }
        }
      }, 
      buttons: [
        { text: SCANNELL_TRANSLATIONS.quickSave,
          scope: this,
          handler: function() {
        	Ext.Msg.alert(SCANNELL_TRANSLATIONS.warning, SCANNELL_TRANSLATIONS.profileWillBeSaved);
            formPanel.getForm().submit();
          }
        },
        { text: SCANNELL_TRANSLATIONS.finish,
          scope: this,
          handler: function() {
            formPanel.getForm().submit({
              params: { finish: true }
            });
            window.onunload = refreshParent;
            function refreshParent() {
            	if(window.opener != null && window.opener != undefined) {
                	window.opener.location.reload();
            	}
            }
          }
        },
        { text: SCANNELL_TRANSLATIONS.cancel,
          scope: this,
          handler: function() {
            this.close();
          }
        }
      ]
    }));
  }
});

//scansol.law.ProfileChecklistRelevancyEditWindow = Ext.extend(Ext.Window, {
//  modal: true,
//  maximized: true,
//  closable: false,
//  title: 'Edit Relevancy',
//  autoScroll: true,
//  bodyCssClass: 'ss-leg',
//  formListeners: null,
//  defaults: {
//    border: false
//  },
//
//  topTpl: new Ext.XTemplate(
//    '<div class="checklist-title law-changeindicator-{changed}">{name}<span class="checklist-id"> [ID#:{id}]</span></div>',
//    '<div class="checklist-description">',
//      '<div class="checklist-description-title">Description:</div>',
//      '{description}',
//    '</div>',
//    '<div class="checklist-description">',
//      '<div class="checklist-description-title">Things to Consider:ABc</div>',
//      '{thingsToConsider}',
//    '</div>'),
//  bottomTpl: new Ext.XTemplate(
//    '<div class="checklist-legislation"> ',
//      '<div> </div>', // extra div is workaround for IE rendering bug
//      '<div class="checklist-legislation-title">Legislation:</div>', 
//      '<tpl for="legislations">',
//      '<table width="100%" border="0" padding="0">',
//        '<tr class="checklist-legislation-item">',
//          '<td style="vertical-align: top; width: 20px;">',
//            '<tpl if="changed"><img src="../legal/images/enviroMANAGER_Application_Bullet2.gif"/><br /></tpl>',  
//            '<img src="../legal/images/{economicRegion}.gif"/>',
//          '</td>',
//          '<td>',
//	          '<a href="legislation.htm?legId={id}&amp;legRegister={registerType}&amp;profileId={parent.profile.id}" target="chk_leg">',
//	              '{name}</a>',
//	          '<tpl for="altLangNames"><br/>◊ {name}</tpl> ',    
//          '</td>',
//        '</tr>',
//      '</table>',
//      '</tpl>',
//    '</div>'),
//
//  initComponent : function() {
//    scansol.law.ProfileChecklistRelevancyEditWindow.superclass.initComponent.call(this);
//
//    this.setTitle('Edit Relevancy for ' + this.checklist.name + ' in Profile ' + this.profile.name);
//    
//    this.on('afterrender', function() {
//      Ext.Ajax.request({
//        url: contextPath + '/law/profile/profileChecklistForProfile',
//        params: { 
//          profileId: this.profile.id, 
//          checklistId: this.checklist.id 
//        },
//        scope: this,
//        success: function(response) {
//          var result = Ext.decode(response.responseText);
//          this.renderChecklist(result.profile, result.checklist, result.profileChecklist);
//          this.doLayout();
//        }
//      });
//    });
//    this.addButton({
//      text: 'Save',
//      scope: this,
//      handler: function() {
//        this.formPanel.getForm().submit();
//      }
//    });
//    this.addButton({
//      text: 'Cancel',
//      scope: this,
//      handler: function() {
//        this.close();
//      }
//    });
//  },
//  renderChecklist: function(profile, checklist, profileChecklist) {
//    checklist.profile = profile; //needed for xtemplate rendering
//    this.add({
//      tpl: this.topTpl,
//      data: checklist,
//      bodyBorder: false
//    });
//    this.formPanel = this.add({
//      xtype: "scansol.FormPanel",
//      url: contextPath + '/law/profile/profileChecklistForProfileSave',
//      labelAlign: 'top',
//      defaults: {
//        labelStyle: 'background-color:#006699; color:#FFFFFF; font-weight:bold; padding:2px;'
//      },
//      items: [
//        { xtype: 'hidden', name: 'id', value: profileChecklist.id },
//        { xtype: 'hidden', name: 'version', value: profileChecklist.version },
//        { xtype: 'hidden', name: 'profile', value: profile.id },
//        { xtype: 'hidden', name: 'checklistId', value: checklist.id },
//        { xtype: 'textarea', name: 'relevance', width: 500, height: 100, fieldLabel: 'Relevance', value: profileChecklist.relevance },
//        { xtype: 'textarea', name: 'evaluationOfCompliance', width: 500, height: 100, fieldLabel: 'Evaluation Of Compliance', value: profileChecklist.evaluationOfCompliance },
//        { xtype: 'button', 
//          text: 'Linked Documents', 
//          scope: this, 
//          handler: function() {
//            scansol.docs.Util.manageLinks("checklist" + checklist.id + "-" + profile.id);         
//          }
//        }
//      ],
//      listeners: {
//        scope: this,
//        successfulSubmit:  this.close
//      }
//    });
//    if(this.formListeners) {
//      this.formPanel.on(this.formListeners);
//      delete this.formListeners;
//    }
//    this.add({
//      tpl: this.bottomTpl,
//      data: checklist,
//      bodyBorder: false
//    });
//  }
//});

scansol.law.ProfileChecklistRelevancyEditWindow = Ext.extend(Ext.Window, {
	  modal: true,
	  maximized: true,
	  closable: false,
	  title: 'Edit Relevancy',
	  autoScroll: true,
	  bodyCssClass: 'ss-leg',
	  formListeners: null,
	  defaults: {
	    border: false
	  },

	  initComponent : function() {
		this.bodyCfg = {
		  tag: 'iframe',
		  src: contextPath + '/law/checklists.htmf?plain=true&hideLinks=true&chklistId='
		         + this.checklist.id + '&profileId=' + this.profile.id
		         + "&ss_default_target=" + (window.opener ? window.opener.name : ""),
		  width: '100%',
		  height: '100%',
		  frameborder: '0'
		};
	    scansol.law.ProfileChecklistRelevancyEditWindow.superclass.initComponent.call(this);

	    this.setTitle('Relevancy for ' + this.checklist.name + ' in Profile ' + this.profile.name);
	    
	    this.addButton({
	      text: 'Close',
	      scope: this,
	      handler: function() {
	        this.close();
	      }
	    });
	  }
	});

scansol.law.ProfileGroupsEditWindow = Ext.extend(Ext.Window, {
  modal: true,
  maximized: true,
  closable: false,
  title: 'Profile Groups',
  autoScroll: true,
  profile: null,
  layout: 'form',
  forceLayout: true,
  anchor: '90%',
  bodyStyle: 'padding:0px 0px 0px 0px; overflow-y: scroll;',
  bodyCssClass: 'ss-leg',
  formListeners: null,
  defaults: {
    border: false
  },

  initComponent: function() {
    scansol.law.ProfileGroupsEditWindow.superclass.initComponent.call(this);
    Ext.getBody().mask(SCANNELL_TRANSLATIONS.loadingG); 
    Ext.Ajax.request({
      url: contextPath + '/law/profile/groupsGet',
      scope: this,
      success: function(response) {
        var profile = Ext.decode(response.responseText);
        this.setTitle(SCANNELL_TRANSLATIONS.selectGroups + profile.name);
        this.addFields(profile);
        Ext.getBody().unmask();
      },
      params: { id: this.profile.id }
    });
    
    this.addButton({
      text: SCANNELL_TRANSLATIONS.saveG,
      scope: this,
      handler: function() {
        this.formPanel.getForm().submit();
      }
    });
    this.addButton({
      text: SCANNELL_TRANSLATIONS.cancel,
      scope: this,
      handler: function() {
        this.close();
      }
    });

  },
  addFields: function(profile) {
    var items = [];
    Ext.each(profile.groups, function(group) {
      items.push({ name: 'groupIds', boxLabel: group.name, inputValue: group.id, checked: group.selected });
    });

    this.formPanel = this.add(new scansol.FormPanel({
      url: contextPath + '/law/profile/groupsSave',
      items: [
        { xtype: 'hidden', name: 'id', value: profile.id },
        { xtype: 'hidden', name: 'version', value: profile.version },
        { xtype: 'checkboxgroup', columns: 1, items: items, fieldLabel: SCANNELL_TRANSLATIONS.groupsG }
      ],
      listeners: {
        scope: this,
        successfulSubmit: function() {
          this.close();
        }
      }
    }));
    this.doLayout();
  }
});


scansol.law.ProfileActiveUsersEditWindow = Ext.extend(Ext.Window, {
  modal: true,
  maximized: true,
  closable: false,
  title: 'Profile Active Users',
  autoScroll: true,
  profile: null,
  bodyCssClass: 'ss-leg',
  formListeners: null,
  defaults: {
    border: false
  },

  initComponent: function() {
    scansol.law.ProfileActiveUsersEditWindow.superclass.initComponent.call(this);
    Ext.Ajax.request({
      url: contextPath + '/law/profile/usersGet',
      scope: this,
      success: function(response) {
        var profile = Ext.decode(response.responseText);
        this.setTitle("Select Users for Profile: " + profile.name);
        this.addFields(profile);
      },
      params: { id: this.profile.id }
    });
    
    this.addButton({
      text: 'Save',
      scope: this,
      handler: function() {
        this.formPanel.getForm().submit();
      }
    });
    this.addButton({
      text: 'Cancel',
      scope: this,
      handler: function() {
        this.close();
      }
    });

  },
  addFields: function(profile) {
    var items = [];
    Ext.each(profile.users, function(user) {
      items.push({ name: 'userIds', boxLabel: user.name, inputValue: user.id, checked: user.selected });
    });
    var groupNames = [];
    Ext.each(profile.groups, function(group) {
      groupNames.push(group.name);
    });

    this.formPanel = this.add(new scansol.FormPanel({
      url: contextPath + '/law/profile/usersSave',
      items: [
        { xtype: 'hidden', name: 'id', value: profile.id },
        { xtype: 'hidden', name: 'version', value: profile.version },
        { xtype: 'textarea', disabled: true, value: groupNames.join('\n'), fieldLabel: 'Groups', width: 300, grow: true }
      ],
      listeners: {
        scope: this,
        successfulSubmit: function() {
          this.close();
        }
      }
    }));
    if(items.length > 0) {
      this.formPanel.add({ xtype: 'checkboxgroup', columns: 1, items: items, fieldLabel: 'Users' });
    }
    this.doLayout();
    if(profile.groups.length === 0) {
      Ext.Msg.alert(profile.name, 'This profile is not shared with any groups, groups must be selected before selecting users.');
      this.close();
    }
  }
});

scansol.law.ProfileTrashUntrashWindow = Ext.extend(Ext.Window, {
  modal: true,
  width: 500,
  height: 150,
  closable: false,
  title: 'Trash/Untrash',
  profile: null,
  trash: true,
  formListeners: null,

  initComponent: function() {
    scansol.law.ProfileTrashUntrashWindow.superclass.initComponent.call(this);

    var profile = this.profile;
    var actionDesc = this.trash ? SCANNELL_TRANSLATIONS.trashProfile : SCANNELL_TRANSLATIONS.restore;
    this.setTitle(SCANNELL_TRANSLATIONS.confirm + actionDesc + " " + SCANNELL_TRANSLATIONS.profileConfirm);
    this.formPanel = this.add(new scansol.FormPanel({
      layout: 'fit',
      url: contextPath + '/law/profile/' + (this.trash ? 'trash' : 'untrash'),
      items: [
        { xtype: 'hidden', name: 'id', value: profile.id },
        { xtype: 'hidden', name: 'version', value: profile.version }
      ],
      listeners: {
        scope: this,
        successfulSubmit: function() {
          this.close();
        }
      }
    }));
    this.add({ 
      xtype: 'panel', 
      html: SCANNELL_TRANSLATIONS.confirm + actionDesc + " " + SCANNELL_TRANSLATIONS.ofProfile + " " + profile.name, 
      height: 200,
      frame: true,
      bodyStyle: 'padding: 20px;'
     });

    this.addButton({
      text: 'OK',
      scope: this,
      handler: function() {
        this.formPanel.getForm().submit();
      }
    });
    this.addButton({
      text: SCANNELL_TRANSLATIONS.cancel,
      scope: this,
      handler: function() {
        this.close();
      }
    });
  }
});

scansol.law.ProfileLocWindow = Ext.extend(Ext.Window, {
	  modal: true,
	  width: 500,
	  height: 150,
	  closable: false,
	  title: SCANNELL_TRANSLATIONS.displayLevelOfCompliance,
	  profile: null,	 
	  formListeners: null,

	  initComponent: function() {
	    scansol.law.ProfileLocWindow.superclass.initComponent.call(this);

	    var profile = this.profile;
	    var showing=SCANNELL_TRANSLATIONS.showingLevelOfCompl
	    var hiding=SCANNELL_TRANSLATIONS.hidingLevelOfCompl
	    var actionDesc = this.loc ? showing : hiding;
	    this.setTitle(SCANNELL_TRANSLATIONS.displayLevelOfCompliance);
	    this.formPanel = this.add(new scansol.FormPanel({
	      layout: 'fit',
	      url: contextPath + '/law/profile/loc?locStatus=' + (this.loc ? 'true' : 'false'),
	      items: [
	        { xtype: 'hidden', name: 'id', value: profile.id },
	        { xtype: 'hidden', name: 'version', value: profile.version }
	      ],
	      listeners: {
	        scope: this,
	        successfulSubmit: function() {	        	
	        	this.close();	        	
	        }
	      }
	    }));
	    this.add({ 
	      xtype: 'panel', 
	      html: SCANNELL_TRANSLATIONS.profileLevelOfCompl + profile.name + '<br><br>' + actionDesc, 
	      height: 200,
	      frame: true,
	      bodyStyle: 'padding: 20px;'
	     });

	    this.addButton({
	      text: 'OK',
	      scope: this,
	      handler: function() {
	        this.formPanel.getForm().submit();
	      }
	    });
	    this.addButton({
	      text: SCANNELL_TRANSLATIONS.cancel,
	      scope: this,
	      handler: function() {
	        this.close();
	      }
	    });
	  }
	});


scansol.law.ContentImportWindow = Ext.extend(Ext.Window, {
  modal: true,
  width: 450,
  height: 200,
  closable: false,
  title: SCANNELL_TRANSLATIONS.importContent,
  layout: 'fit',

  initComponent: function() {
    scansol.law.ContentImportWindow.superclass.initComponent.call(this);

    this.formPanel = this.add(new scansol.FormPanel({
      fileUpload: true,
      disableButtonsOnParent: true,
      waitMsgTarget: true,
      url: contextPath + '/law/contentImport',
      defaultType: 'textfield',
      bodyStyle: 'padding:5px 5px 0',
      labelWidth: 150,
      
      items: [
        { inputType: 'hidden', name: 'htmlEscapeErrors', value: 'true' },
        { inputType: 'file', name: 'content', fieldLabel: SCANNELL_TRANSLATIONS.contentFile },
        { inputType: 'password', name: 'password', fieldLabel: SCANNELL_TRANSLATIONS.contentPassword + " "}
      ],
      listeners: {
        scope: this,
        successfulSubmit: function() {
          this.close();
          Ext.Msg.alert(SCANNELL_TRANSLATIONS.contentImport, SCANNELL_TRANSLATIONS.importComplSuccess, function() {
            window.location.reload();
          });
        }
      }
    }));
    this.addButton({
      text: 'OK',
      scope: this,
      handler: function() {
        this.formPanel.getForm().submit({
          waitMsg:SCANNELL_TRANSLATIONS.importing
        });
      }
    });
    this.addButton({
      text: SCANNELL_TRANSLATIONS.cancel,
      scope: this,
      handler: function() {
        this.close();
      }
    });
  } 
});


scansol.law.ProfilesGrid = Ext.extend(Ext.grid.GridPanel, {
  loadMask: true,  
  initComponent: function() {
    this.cm = new Ext.grid.ColumnModel({
      columns: [
        { header: SCANNELL_TRANSLATIONS.idProf, sortable: true, dataIndex: 'id', width: 3 },
        { header: SCANNELL_TRANSLATIONS.nameProf, sortable: true, dataIndex: 'name', width: 15 },
        { header: SCANNELL_TRANSLATIONS.typeProf, sortable: true, dataIndex: 'registerTypeName', width: 8 },
        { header: SCANNELL_TRANSLATIONS.primaryOwnerProf, sortable: true, dataIndex: 'effectiveOwnerName', width: 8 },
        { header: SCANNELL_TRANSLATIONS.secondaryOwnerProf, sortable: true, dataIndex: 'ownerName', width: 8 },
        { header: SCANNELL_TRANSLATIONS.stateProf, sortable: true, dataIndex: 'stateDesc', width: 5 },
        { header: SCANNELL_TRANSLATIONS.descriptionProf, sortable: true, dataIndex: 'description', width: 20 },
        { header: SCANNELL_TRANSLATIONS.versionProf, 
          sortable: true, 
          dataIndex: 'contentVersion', 
          width: 3, 
          align: 'left', 
          renderer: function(value, metaData, record, rowIndex, colIndex, store) {
        	  var latestContentVersion = record.get('latestContentVersion');
        	  if(value < latestContentVersion) {
        		  metaData.css = "ss-profile-version-out-of-date";
        	  }
        	  return value;
          }
        }
      ],
      defaults: {
        sortable: true
      }
    });
    this.sm = new Ext.grid.RowSelectionModel({
      singleSelect: true,
      listeners: {
        scope: this,
        rowselect: function(selModel, rowIndex, record) {
          var profile = record.json;
          this.getTopToolbar().items.each(function(item) {
            if (item.profileSelected) {
              item.profileSelected(profile);
            }
          });
        }
      }
    });
    
    this.store = new Ext.data.Store({
      autoLoad: true,
      autoDestroy: true,
      url: contextPath + '/law/profile/list',
      baseParams: {
        states: 'ACTIVE,UNFINISHED'
      },
      reader: new Ext.data.JsonReader({
        idProperty: 'id',
        root: 'profiles',
        fields: ['id', 'version', 'contentVersion', 'latestContentVersion', { name: 'name', sortType: Ext.data.SortTypes.asUCString }, 'description', 'registerType', 'effectiveOwner', 'owner', 'stateDesc', 'effectiveOwnerName', 'ownerName', 'registerTypeName']
      }),
      listeners: {
        scope: this,
        load: function(store) {
          if(autoEditProfileId) {
            var autoEditRecord = store.getById(autoEditProfileId);
            autoEditProfileId = null;
            if (autoEditRecord) {
              this.getSelectionModel().selectRecords([autoEditRecord]);
              (function() {
                this.el.unmask();
                this.editProfile(autoEditRecord.json, true);
              }).defer(500, this);
              return;
            }
          }
          if(!this.getSelectionModel().hasSelection()) {
            this.getSelectionModel().selectRow(0);
          }
        }
      }
    });
	//var v ="test"; alert(SCANNELL_TRANSLATIONS.test1)
    
    this.tbar = [
      {
        text: SCANNELL_TRANSLATIONS.newTbar,
        icon: contextPath + '/images/new.png',
        scope: this,
        disabled: !profileCreateAllowed,
        handler: function() {
          this.editProfile(null);
        }
      },
      {
        text: SCANNELL_TRANSLATIONS.editTbar,
        icon: contextPath + '/images/edit.png',
        scope: this,
        handler: function() {
          this.editProfile(this.getSelectionModel().getSelected().json);
        },
        profileSelected: function(profile) {
          this.setDisabled(profile.editAllowed !== true);
        }
      },
      /*{ text: 'Manage Other Requirements', 
        icon: contextPath + '/images/edit.png',
        scope: this, 
        handler: function() {        	
          scansol.docs.Util.manageLinks("Profile - " + this.getSelectionModel().getSelected().json.id);         
        },
        profileSelected: function(profile) {
          this.setDisabled(profile.editAllowed !== true);
        }
      },*/
      '-',
      {
        text: SCANNELL_TRANSLATIONS.viewSummarTbar,
        icon: contextPath + '/images/view.png',
        scope: this,
        handler: function() {
          var profile = this.getSelectionModel().getSelected().json;
          var win = window.open(contextPath + "/law/profileSummary.jsp?profileId=" + profile.id, "profileSummary", 
              "toolbar=no,directories=no,location=no,status=no,menubar=no,resizable=no,scrollbars=yes,width="+(screen.width-20)+",height="+(screen.height-20)+",top=10,left=10");
          win.focus();
        }
      },
      '-',
      {
        text: SCANNELL_TRANSLATIONS.sharingTbar,
        icon: contextPath + '/images/window/default/maximize.giff',
        scope: this,
        handler: function() {
          var dialog = new scansol.law.ProfileGroupsEditWindow({
            profile: this.getSelectionModel().getSelected().json,
            listeners: {
              scope: this,
              close: function() {
                this.getStore().reload();
              }
            }
          });
          dialog.show();
        },
        profileSelected: function(profile) {
          this.setDisabled(profile.shareAllowed !== true);
        }
      }, 
//      {
//        text: 'Select For Use',
//        icon: contextPath + '/images/open.gif',
//        scope: this,
//        handler: function() {
//          var dialog = new scansol.law.ProfileActiveUsersEditWindow({
//            profile: this.getSelectionModel().getSelected().json,
//            listeners: {
//              scope: this,
//              close: function() {
//                this.getStore().reload();
//              }
//            }
//          });
//          dialog.show();
//        },
//        profileSelected: function(profile) {
//          this.setDisabled(profile.setupUsersAllowed !== true);
//        }
//      },
      '-',
      {
        text: SCANNELL_TRANSLATIONS.trashTbar,
        icon: contextPath + '/images/trash.gif',
        scope: this,
        handler: function() {
          this.trashUntrash(true);
        },
        profileSelected: function(profile) {
          this.setDisabled(profile.trashAllowed !== true);
        }
      },
      {
        text: SCANNELL_TRANSLATIONS.restoreTbar,
        icon: contextPath + '/images/untrash.gif',
        scope: this,
        handler: function() {
          this.trashUntrash(false);
        },
        profileSelected: function(profile) {
          this.setDisabled(profile.untrashAllowed !== true);
        }
      },
      '-',
      {
    	  
        xtype: 'checkbox',
        boxLabel: SCANNELL_TRANSLATIONS.levelOfComplianceTbar,
        id:'loc',
        itemId: 'loc',
        hideLabel: true,
        margin: '0 10 0 20',        
        scope: this,
        handler: function(evt) {        	
        	if(event != undefined || event != null){        		
        		if(event.srcElement){
        		if(event.srcElement.id == 'loc'){
        			var checkbox1 = Ext.getCmp('loc');
        			this.levelOfCompliance(checkbox1.getValue());
        		}
        		}
        	}        	
          },
        
        profileSelected: function(profile) {
            this.setDisabled(profile.shareAllowed !== true);
           /* if(profile.shareAllowed){*/
            	var checkbox1 = Ext.getCmp('loc');
            	if(profile.loc){            		
            		checkbox1.setValue(true);
            	}else{
            		checkbox1.setValue(false);
            	}
            /*} */                               
          }
        },
        '-',
      {
        text: SCANNELL_TRANSLATIONS.refreshListTbar,
        icon: contextPath + '/images/refresh.gif',
        scope: this,
        handler: function() {
          this.getStore().reload();
        }
      },   
      '-',
      {
        xtype: 'lovcombo',
        mode: 'local',
        triggerAction: 'all',
        beforeBlur: Ext.emptyFn,
        hideOnSelect: false,
        store: scansol.law.profileStateDataStore,
        displayField: 'name',
        valueField: 'id',
        listeners: {
          select: {
            scope: this,
            fn: function(combo) {
              var store = this.getStore();
              store.baseParams.states = combo.getValue();
              store.reload();
            } 
          }, 
          afterrender: {
            scope: this,
            fn: function(combo) {
              var store = this.getStore();
              if(store.getCount() > 0) {
                combo.setValue(this.getStore().baseParams.states)
              } else {
                store.on('load', function(s) {
                  combo.setValue(s.baseParams.states)
                });
              }
                
            } 
          }
        }
      },      
      '-',
      {
        text: SCANNELL_TRANSLATIONS.contentImportTbar,
        icon: contextPath + '/images/plus.gif',
        disabled: !profileCreateAllowed,
        scope: this,
        handler: function() {
          (new scansol.law.ContentImportWindow()).show();
        }
      }
       
    ];
    
    scansol.law.ProfilesGrid.superclass.initComponent.call(this);
    
    if(ss_cgen === true) {
      this.getTopToolbar().add(
	      '|',
	      { text: 'Generate',
	        icon: contextPath + '/images/save.gif',
	        scope: this,
	        handler: function() {
            	Ext.Msg.wait('Generation in progress, please wait', 'Content Generator');
	            Ext.Ajax.request({
	                url: contextPath + '/law//profileGenerate',
	                params: {
	                  profileId: this.getSelectionModel().getSelected().json.id
	                },
	                timeout: 180000,
	                scope: this,
	                success: function(response) {
	                	var result = Ext.decode(response.responseText);
	                	Ext.Msg.alert('Content Generation', 'Generation completed successfully.', function() {
	                      var downloadIframeId = "ss.downloadIframe";
	                      var downloadIframe = Ext.get(downloadIframeId);
	                      if(!downloadIframe) {
	                        downloadIframe = Ext.getBody().createChild({
	                          tag: 'iframe',
	                          id: downloadIframeId
	                        });
	                      }
	                      downloadIframe.set({ src: contextPath + '/law/profileDownload?file=' + result.file });
	                    });
	                }
	              });
	        }
	      }
    		  
      );
    }
  },
  
  editProfile: function(profile, jumpToChecklistsTabOnOpen) {
    var editWindow = new scansol.law.ProfileQuestionnaireWindow({
      profile: profile,
      jumpToChecklistsTabOnOpen: jumpToChecklistsTabOnOpen,
      listeners: {
        scope: this,
        close: function() {
          this.getStore().reload();
        }
      }
    });
    editWindow.show();
  },
  trashUntrash: function(trash) {
    var dialog = new scansol.law.ProfileTrashUntrashWindow({
      trash: trash,
      profile: this.getSelectionModel().getSelected().json,
      listeners: {
        scope: this,
        close: function() {
          this.getStore().reload();
        }
      }
    });
    dialog.show();
  },
  levelOfCompliance: function(loc) {
	    var dialog = new scansol.law.ProfileLocWindow({
	      loc: loc,
	      profile: this.getSelectionModel().getSelected().json,
	      listeners: {
	        scope: this,
	        close: function() {
	          this.getStore().reload();	          
	        }
	      }
	    });
	    dialog.show();
	  }
});


Ext.onReady(function() {
	
  Ext.QuickTips.init();
  Ext.form.Field.prototype.msgTarget = 'qtip';
 
  var opener = window.opener;
  if(opener) {
	if(!opener.name) {
		opener.name = "ss-" + (new Date().getTime());
	}
  }

  (new Ext.Viewport( {
    layout : 'border',
    items : [
      new scansol.law.ProfilesGrid({
        layout: 'fit',
        region: 'center',
        viewConfig: {
          autoFill: true
        }
      })
    ]
  }));

});