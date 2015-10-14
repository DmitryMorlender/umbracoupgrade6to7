using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using Umbraco.Forms.Core;

namespace Centennial.CustomFormFields
{
    public class WCAGDatePicker: Umbraco.Forms.Core.FieldType
    {
        public WCAGDatePicker()
        {
   
           //Provider
           this.Id = new Guid("227D26B2-0A7F-4CF6-BE70-FCC87861C599");
           this.Name = "WCAG Date Picker";
           this.Description = "A WCAG date picker";
           this.Icon = "icon-calendar";
           this.DataType = FieldDataType.String;
		   this.HideLabel = false;
        }
		
		 public override IEnumerable<string> RequiredJavascriptFiles(Field field)
        {
			List<string> returnValue = new List<string>();
			returnValue.Add("/App_Plugins/UmbracoForms/Assets/wcagdatepicker/wcagdatepicker.js");
            return returnValue;
            
        }

        public override IEnumerable<string> RequiredCssFiles(Field field)
        {
            List<string> returnValue = new List<string>();
			returnValue.Add("/App_Plugins/UmbracoForms/Assets/wcagdatepicker/wcagdatepicker.css");
            return returnValue;
        }
		
    }
}