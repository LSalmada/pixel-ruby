import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="pixel-ruby--command-dialog"
export default class extends Controller {
  static targets = ["content"];
  static outlets = ["pixel-ruby--command"];

  pixelRubyCommandOutletConnected(controller) {
    this.openOutlet = controller;
  }

  pixelRubyCommandOutletDisconnected() {
    this.openOutlet = null;
  }

  open(e) {
    if (e) {
      e.preventDefault();
    }

    if (!this.hasContentTarget) {
      return;
    }

    if (this.openOutlet) {
      this.openOutlet.show();
      return;
    }

    document.body.insertAdjacentHTML("beforeend", this.contentTarget.innerHTML);
    // prevent scroll on body
    document.body.classList.add("overflow-hidden");
  }
}
