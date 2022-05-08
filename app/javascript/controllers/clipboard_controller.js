import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['source']

  copy() {
    let content = this.sourceTarget.value

    alert(content);
  }
}
