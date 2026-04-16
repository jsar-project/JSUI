import wx from 'wx';

export default {
  onLoad() {
    console.log('Transform test page loaded');

    // Test wx.playTTS
    wx.speech.playTTS('Hello from wx.playTTS');

    // Test SpeechSynthesisUtterance + speechSynthesis
    const utterance = new SpeechSynthesisUtterance('Hello from SpeechSynthesisUtterance');
    utterance.lang = 'en-US';
    utterance.pitch = 1.5;
    utterance.rate = 1.0;
    utterance.volume = 0.8;

    if (typeof speechSynthesis !== 'undefined') {
      speechSynthesis.speak(utterance);
      setTimeout(() => {
        this.finish();
      }, 1000);
    } else {
      console.error('speechSynthesis is not defined');
    }
  },
};
