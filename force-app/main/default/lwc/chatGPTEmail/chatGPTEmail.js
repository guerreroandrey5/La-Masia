import { LightningElement, track, wire, api } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import ChatGPTAPI from "@salesforce/apex/openAIClass.ChatGPTAPI";
import PROMPT_FIELD from "@salesforce/schema/ChatGPT_Prompt__c.Prompt__c";
import getPicklistValues from "@salesforce/apex/getPickList.getPicklistValues";

export default class ChatGPTEmail extends LightningElement {
  @api objectApiName;
  @track options = [];
  showPickList = false;
  messagefromGPT;
  tPrompt;
  @wire(getPicklistValues) pickListValues({ data, error }) {
    if (data) {
      this.showPickList = true;
      data.forEach((i) => {
        this.options.push({ label: i, value: i });
      });
      console.log(this.options);
    }
    if (error) {
      console.log(error);
    }
  }
  @track uPrompt = PROMPT_FIELD;
  @track pValue = this.objectApiName;
  gpt = {
    Prompt__c: this.uPrompt,
    Object_Picklist__c: this.pValue
  };

  handlePrompt(event) {
    this.gpt.Object_Picklist__c = this.objectApiName;
    this.gpt.Prompt__c = event.target.value;
  }
  handleSend() {
    if (this.gpt.Prompt__c === "") {
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error",
          message: "Please enter a prompt.",
          variant: "error"
        })
      );
    } else {
      let mGPT;
      ChatGPTAPI({ gpt: this.gpt })
        .then((result) => {
          this.message = result;
          this.error = undefined;
          if (this.message !== undefined) {
            this.gpt.Prompt__c = "";
            this.gpt.Object_Picklist__c = "";
            this.dispatchEvent(
              new ShowToastEvent({
                title: "Success",
                message: "The prompt was sent successfully.",
                variant: "success"
              })
            );
          }
          mGPT = JSON.parse(this.message);
          this.messagefromGPT = mGPT.choices[0].message.content;
          this.tPrompt = "";
        })
        .catch((error) => {
          this.message = undefined;
          this.error = error;
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Error while sending prompt",
              message: error.body.message,
              variant: "error"
            })
          );
        });
    }
  }
}