import { LightningElement } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class PercentageCalculator extends LightningElement {
  valueCB = 0;
  calculatedValue = 0;
  inputValue = 0;
  clickedButtonLabel;
  get options() {
    return [
      { label: "10%", value: "10" },
      { label: "20%", value: "20" },
      { label: "30%", value: "30" },
      { label: "40%", value: "40" },
      { label: "50%", value: "50" }
    ];
  }
  handleChange(event) {
    this.valueCB = event.detail.value;
  }
  handleChanges(event) {
    this.inputValue = event.detail.value;
  }
  handleClick() {
    if (
      this.valueCB === 0 ||
      this.inputValue === 0 ||
      this.valueCB === undefined ||
      this.inputValue === undefined ||
      this.valueCB < 0 ||
      this.inputValue < 0
    ) {
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Error",
          message: "Verify the values",
          variant: "error"
        })
      );
    } else {
      this.calculatedValue = (this.valueCB / 100) * this.inputValue;
    }
  }
}