import { LightningElement, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import ACCOUNTID_FIELD from "@salesforce/schema/Contact.AccountId";
import FIRST_NAME_FIELD from "@salesforce/schema/Contact.FirstName";
import LAST_NAME_FIELD from "@salesforce/schema/Contact.FirstName";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import PHONE_FIELD from "@salesforce/schema/Contact.Phone";
import COMPANY_FIELD from "@salesforce/schema/Contact.Company_Name__c";
import MESSAGE_FIELD from "@salesforce/schema/Contact.Message__c";
import createContact from "@salesforce/apex/createCon.createContact";

export default class SusbcribeForm extends LightningElement {
  @track fname = FIRST_NAME_FIELD;
  @track lname = LAST_NAME_FIELD;
  @track email = EMAIL_FIELD;
  @track phone = PHONE_FIELD;
  @track message = MESSAGE_FIELD;
  @track companyname = COMPANY_FIELD;
  @track accountid = ACCOUNTID_FIELD;

  con = {
    FirstName: this.fname,
    LastName: this.lname,
    Email: this.email,
    Phone: this.phone,
    Message__c: this.message,
    Company_Name__c: this.companyname,
    AccountId: "0013C00000p8NC8QAM"
  };
  handlefname(event) {
    this.con.FirstName = event.target.value;
  }
  handlelname(event) {
    this.con.LastName = event.target.value;
  }
  handlecompanyName(event) {
    this.con.Company_Name__c = event.target.value;
  }
  handlemail(event) {
    this.con.Email = event.target.value;
  }
  handlephone(event) {
    this.con.Phone = event.target.value;
  }
  handlemessage(event) {
    this.con.Message__c = event.target.value;
  }
  handleClick() {
    createContact({ con: this.con })
      .then((result) => {
        this.message = result;
        this.error = undefined;
        if (this.message !== undefined) {
          this.con.FirstName = "";
          this.con.LastName = "";
          this.con.Email = "";
          this.con.Phone = "";
          this.con.Message__c = "";
          this.con.Company_Name__c = "";
          this.con.AccountId = "0013C00000p8NC8QAM";
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Success",
              message: "Contact created",
              variant: "success"
            })
          );
        }

        console.log(JSON.stringify(result));
        console.log("result", this.message);
      })
      .catch((error) => {
        this.message = undefined;
        this.error = error;
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error creating record",
            message: error.body.message,
            variant: "error"
          })
        );
        console.log("error", JSON.stringify(this.error));
      });
  }
}