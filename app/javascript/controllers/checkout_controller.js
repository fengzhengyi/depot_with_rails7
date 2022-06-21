import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static  targets = ['checkout']

    initialize() {
        this.checkoutTarget.disabled = (window.location.pathname == "/orders/new")
    }

    click() {
        setTimeout(()=>this.checkoutTarget.disabled=true,0)
    }
}