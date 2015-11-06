using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Umbraco.Forms.Core;
using Umbraco.Forms.Core.Attributes;
using Umbraco.Forms.Core.Enums;
using Umbraco.Forms.Data.Storage;
using Umbraco.Forms.Core.Services;
using Umbraco.Forms.Data;

using umbraco.BusinessLogic;
using System.Web.Configuration;
using System.Net.Mail;
using umbraco;
using System.Xml;
using Umbraco.Core.Configuration;

namespace Centennial.DAL
{
    public class XSLTAndMessage : WorkflowType
    {
        public XSLTAndMessage()
        {
            this.Id = new Guid("7D86C6E1-5831-491D-B1E5-70520FBC75E2");
            this.Name = "XSLT and Message";
            this.Description = "Send XSLT and Message Workflow";
        }

        #region Properties



        /// <summary>
        /// Gets or sets Email.
        /// </summary>
        [Setting("Email", description = "Enter the receiver email",
            view = "TextField")]
        public string Email { get; set; }

        /// <summary>
        /// Gets or sets From Email.
        /// </summary>
        [Umbraco.Forms.Core.Attributes.Setting("From Email", description = "Enter the from email (optional)", view = "TextField")]
        public string FromEmail { get; set; }

        /// <summary>
        /// Gets or sets From Name.
        /// </summary>
        [Umbraco.Forms.Core.Attributes.Setting("From Name", description = "Enter the from name (optional)", view = "TextField")]
        public string FromName { get; set; }

        /// <summary>
        /// Gets or sets Message.
        /// </summary>
        [Setting("Message", description = "Enter in message", view = "TextArea")]
        public string Message { get; set; }

        /// <summary>
        /// Gets or sets Subject.
        /// </summary>
        [Setting("Subject", description = "Enter the subject", view = "TextField")]
        public string Subject { get; set; }

        /// <summary>
        /// Gets or sets XsltFile.
        /// </summary>
        [Setting("XsltFile",
            description =
                "Transform the xml before posting it,<a target='_blank' href='xslt/postAsXmlSample.xslt'>(Sample file)</a>",
            prevalues = "XsltEmail",
            view = "File")]
        public string XsltFile { get; set; }

        #endregion






        public override WorkflowExecutionStatus Execute(Record record, RecordEventArgs e)
        {

            MailAddress FromMailAddress;
            if (string.IsNullOrEmpty(this.FromEmail))
            {
                var settings = UmbracoConfig.For.UmbracoSettings();
                FromMailAddress = new MailAddress(settings.Content.NotificationEmailAddress);
            }
            else
            {
                string fromEmailField = this.FromEmail;
                string fromNameField = "";
                bool fromEmailFound = false;
                bool fromNameFound = false;

                try
                {

                    foreach (RecordField rf in record.RecordFields.Values)
                    {


                        string refinedCaption = "{" + rf.Field.Caption.ToLower().Replace(" ", "") + "}";
                        if (!fromEmailFound && refinedCaption == this.FromEmail.ToLower())
                        {
                            fromEmailField = rf.ValuesAsString();
                            fromEmailFound = true;
                        }
                        else if (!fromNameFound && !String.IsNullOrEmpty(this.FromName) && refinedCaption == this.FromName.ToLower())
                        {
                            fromNameField = rf.ValuesAsString();
                            fromNameFound = true;
                        }
                        //dont go any further to not waste time looking for something already there
                        if (fromEmailFound && fromNameFound)
                        {
                            break;
                        }
                    }
                    if (fromNameFound)
                    {
                        FromMailAddress = new MailAddress(fromEmailField, fromNameField);
                    }
                    else if (!string.IsNullOrEmpty(this.FromName))
                    {
                        FromMailAddress = new MailAddress(fromEmailField, this.FromName);
                    }
                    else
                    {
                        FromMailAddress = new MailAddress(fromEmailField);
                    }
                }
                catch (Exception ex)
                {
                    var settings = UmbracoConfig.For.UmbracoSettings();
                    FromMailAddress = new MailAddress(settings.Content.NotificationEmailAddress);
                }
            }
            var mailMessage = new MailMessage
            {
                From = FromMailAddress,
                Subject = this.Subject,
                ReplyTo = FromMailAddress,
                IsBodyHtml = true,
                BodyEncoding = Encoding.UTF8
            };

            if (this.Email.Contains(";"))
            {
                foreach (string email in this.Email.Split(';'))
                {
                    mailMessage.To.Add(email.Trim());
                }
            }
            else
            {
                mailMessage.To.Add(this.Email);
            }

            XmlNode xml = record.ToXml(new System.Xml.XmlDocument());


            // we will by default set the body to the record xml so if no xslt file is
            // present we atleast get the raw data.
            string result = xml.OuterXml;
            if (!string.IsNullOrEmpty(this.XsltFile))
            {
                result = XsltHelper.TransformXML(xml, this.XsltFile, null);
            }



            mailMessage.Body = "<p>" + Message + "</p><br />" + result;

            var smtpClient = new SmtpClient { EnableSsl = false };

            if (WebConfigurationManager.AppSettings.AllKeys.Contains("contourContribUseSsl") && WebConfigurationManager.AppSettings["contourContribUseSsl"].ToLower() == true.ToString().ToLower())
            {
                smtpClient.EnableSsl = true;
            }

            smtpClient.Send(mailMessage);



            return WorkflowExecutionStatus.Completed;

        }

        /// <summary>
        /// The validate settings.
        /// </summary>
        /// <returns>
        /// A list of exceptions.
        /// </returns>
        public override List<Exception> ValidateSettings()
        {
            var exceptions = new List<Exception>();


            if (string.IsNullOrEmpty(this.Email))
            {
                exceptions.Add(new Exception("'Email' setting not filled out'"));
            }

            if (string.IsNullOrEmpty(this.Subject))
            {
                exceptions.Add(new Exception("'Subject' setting not filled out'"));
            }

            return exceptions;
        }

    }
}