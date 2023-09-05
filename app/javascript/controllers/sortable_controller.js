import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs';

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    tripid: String
  }
  connect() {
    console.log(this.tripidValue);
    const tripid = this.tripidValue
    Sortable.create(this.element,
    {
      onEnd: function (evt) {
      var itemEl = evt.item;
      console.log(evt);
      console.log(evt.newIndex);
      console.log(evt.oldIndex);
      console.log(tripid);

      fetch(`${tripid}`, {
        method: "PATCH",
        headers: {
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
          "Content-Type": "application/json"
        },
        body: JSON.stringify({ newIndex: evt.newIndex, oldIndex: evt.oldIndex })
      })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })





    }})
  }
}
