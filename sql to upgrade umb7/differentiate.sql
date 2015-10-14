USE [dev_CentennialStage]
GO

/***TABLE - cmsMacroProperty**/

SELECT * FROM cmsMacroProperty ORDER BY macroPropertyType 
GO

ALTER TABLE cmsMacroProperty
	ADD editorAlias nvarchar(255)
GO

UPDATE cmsMacroProperty
	SET editorAlias = 'Umbraco.MediaPicker'
WHERE macroPropertyType = 3
GO

UPDATE cmsMacroProperty
	SET editorAlias = 'Umbraco.ContentPickerAlias'
WHERE macroPropertyType = 6
GO

UPDATE cmsMacroProperty
	SET editorAlias = 'Umbraco.Integer'
WHERE macroPropertyType = 13
GO

UPDATE cmsMacroProperty
	SET editorAlias = 'Umbraco.Textbox'
WHERE macroPropertyType = 16
GO

UPDATE cmsMacroProperty
	SET editorAlias = 'Umbraco.TextboxMultiple'
WHERE macroPropertyType = 25
GO

UPDATE cmsMacroProperty
	SET editorAlias = 'UmbracoForms.FormPicker'
WHERE macroPropertyType = 1029
GO



/***custom properties that we need to create**/
UPDATE cmsMacroProperty
	SET editorAlias = 'TwoColumnMacro'
WHERE macroPropertyType = 26
GO
UPDATE cmsMacroProperty
	SET editorAlias = 'SingleColumnMacro'
WHERE macroPropertyType = 27
GO

UPDATE cmsMacroProperty
	SET editorAlias = 'Richtext editor'
WHERE macroPropertyType = 1026
GO

UPDATE cmsMacroProperty
	SET editorAlias = 'SportType'
WHERE macroPropertyType = 1027
GO

UPDATE cmsMacroProperty
	SET editorAlias = 'RightColumnMacro'
WHERE macroPropertyType = 1028
GO

UPDATE cmsMacroProperty	
SET editorAlias = 'Umbraco.SingleColumnMacro'
	WHERE macroPropertyAlias IN ('firstColumn',
'secondColumn',
'thirdColumn')
GO

UPDATE cmsMacroProperty	
SET editorAlias = 'Umbraco.TwoColumnMacro'
	WHERE macroPropertyAlias IN ('leftColumn')
GO
UPDATE cmsMacroProperty	
SET editorAlias = 'Umbraco.RightColumnMacro'
	WHERE macroPropertyAlias IN ('rightColumn')
GO

SELECT * FROM cmsMacroProperty ORDER BY macroPropertyType 
GO

/**drop foreign key**/
ALTER TABLE cmsMacroProperty DROP FK_cmsMacroProperty_cmsMacroPropertyType_id
GO

/**drop defaults**/
ALTER TABLE cmsMacroProperty DROP CONSTRAINT DF_cmsMacroProperty_macroPropertyHidden
GO

/**drop columns**/
ALTER TABLE cmsMacroProperty DROP COLUMN macroPropertyType
GO

ALTER TABLE cmsMacroProperty DROP COLUMN macroPropertyHidden
GO

ALTER TABLE cmsMacroProperty
	ALTER COLUMN editorAlias nvarchar(255) NOT NULL
GO


/***TABLE - cmsDocument**/
ALTER TABLE cmsDocument DROP COLUMN alias
GO

/***TABLE - umbracoUser**/
ALTER TABLE umbracoUser DROP COLUMN userDefaultPermissions
GO
ALTER TABLE umbracoUser DROP CONSTRAINT DF_umbracoUser_defaultToLiveEditing
GO
ALTER TABLE umbracoUser DROP COLUMN defaultToLiveEditing
GO

/***TABLE - cmsDataType**/
ALTER TABLE cmsDataType
	ADD [propertyEditorAlias] nvarchar(255)
GO

/**DEFAULT**/
UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.ColorPickerAlias'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Approved Color')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.CheckBoxList'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Checkbox list')

GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.ContentPickerAlias'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Content Picker')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.Date'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Date Picker')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.DateTime'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Date Picker with time')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.DropDown'
WHERE controlId = 'A74EA9C9-8E18-4D2A-8CF6-73C6206C5DA6'
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.DropDownMultiple'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Dropdown multiple')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.FolderBrowser'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Folder Browser')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.ImageCropper'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Image Cropper')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.NoEdit'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Label')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.MediaPicker'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Media Picker')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.MemberPicker'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Member Picker')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.Integer'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Numeric')
GO


UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.RadioButtonList'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Radiobox')
GO


UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.RelatedLinks'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Related Links')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.TinyMCEv3'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Richtext editor')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.Tags'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Tags')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.TextboxMultiple'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Textbox multiple')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.Textbox'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Textstring')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.TrueFalse'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'True/false')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.UploadField'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Upload')
GO

/**Using existing property but custom name**/
UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.DropDown'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Colts Slider Belongs To')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'UmbracoForms.FormPicker'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Form picker')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.MacroContainer'
WHERE controlId = '474FCFF8-9D2D-11DE-ABC6-AD7A56D89593'
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.RadioButtonList'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Player Gender')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'Umbraco.TextboxMultiple'
WHERE controlId = 'B8A9A4E8-73F8-4F4A-A1EE-3F64053654B3'
GO

/**Custom**/
UPDATE cmsDataType
	SET propertyEditorAlias = 'CKEditor'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'CKEditor')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'CKEditor'
WHERE nodeId = (SELECT TOP 1 id FROM umbracoNode WHERE text = 'Simple Editor')
GO

UPDATE cmsDataType
	SET propertyEditorAlias = 'UserControl'
WHERE controlId = 'D15E1281-E456-4B24-AA86-1DDA3E4299D5'
GO


UPDATE cmsDataType
	SET propertyEditorAlias = 'FigureOutLater'
WHERE propertyEditorAlias IS NULL
GO



SELECT cmsDataType.*
	  , text
  FROM cmsDataType
  LEFT JOIN umbracoNode
  ON cmsDataType.nodeId = umbracoNode.id
  ORDER BY text
  
  
/**https://our.umbraco.org/forum/umbraco-7/using-umbraco-7/59763-V72-InvalidCompositionException**/
SELECT parentNode.id, parentNode.text, childNode.id, childNode.text
  FROM cmsContentType2ContentType joiner
  LEFT JOIN umbracoNode parentNode
  ON parentNode.id = joiner.parentContentTypeId
  LEFT JOIN umbracoNode childNode
  ON childNode.id = joiner.childContentTypeId
  UPDATE cmsPropertyType
	SET Alias = 'externalURL2'
  WHERE id = 2768
  GO

  UPDATE cmsPropertyType
	SET Alias = 'navigationText2'
  WHERE id = 2769
  GO

