import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filters"
export default class extends Controller {
  connect() {
    this.element.addEventListener('change', () => {
      this.submitForm();
    });
  }

  submitForm() {
    this.element.submit();
  }
}
