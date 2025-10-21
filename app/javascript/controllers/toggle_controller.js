import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = [ "options" ]

  toggleOptions(event) {
    const selectedType = event.target.value;
    const optionsContainer = this.optionsTarget;

    if (selectedType === "multiple_choice" || selectedType === "multiple_choice_and_free_text") {
      optionsContainer.style.display = "block";
    } else {
      optionsContainer.style.display = "none";
    }
  }
}