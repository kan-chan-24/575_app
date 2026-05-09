import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["submit", "top", "middle", "bottom", "topCount", "middleCount", "bottomCount"]
  
  connect() {
    this.isSubmitting = false
  }
  
  // 音数をリアルタイムで更新
  updateMoraeCount(target) {
    const fieldName = target.name.match(/\[(\w+)\]$/)?.[1] // "post[top]" から "top" を抽出
    if (!fieldName) return
    
    const countTarget = this[`${fieldName}CountTarget`]
    if (!countTarget) return
    
    const text = target.value
    const count = this.countMorae(text)
    countTarget.textContent = `${count}音`
  }
  
  // 入力中にリアルタイムで音数を表示
  onInput(event) {
    this.updateMoraeCount(event.target)
  }
  
  // 音数カウントロジック（Rubyのロジックを移植）
  countMorae(text) {
    if (!text) return 0
    
    // カタカナをひらがなに変換
    const normalized = text.replace(/[\u30A1-\u30F6]/g, (match) => {
      return String.fromCharCode(match.charCodeAt(0) - 0x60)
    })
    
    let count = 0
    const chars = normalized.split('')
    
    chars.forEach((char, index) => {
      // 小文字（拗音）はスキップ
      if (/[ぁぃぅぇぉゃゅょゎ、。]/.test(char)) {
        return
      }
      
      // ひらがな
      if (/[ぁ-ん]/.test(char)) {
        count++
      }
      // 数字
      else if (/[0-9０-９]/.test(char)) {
        count++
      }
      // 長音
      else if (/[ー]/.test(char)) {
        count++
      }
    })
    
    return count
  }
  
  // 二重送信を防止
  preventDoubleSubmit(event) {
    if (this.isSubmitting) {
      event.preventDefault()
      return
    }
    
    this.isSubmitting = true
    this.submitTarget.disabled = true
  }
}