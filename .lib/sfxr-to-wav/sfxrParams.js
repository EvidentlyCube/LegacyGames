export class SfxrParams {
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    paramsDirty;

    /* Shape of the wave (0:square, 1:saw, 2:sin or 3:noise) */
    _waveType = 0;

    /* Overall volume of the sound (0 to 1) */
    _masterVolume = 0.5;

    /* Length of the volume envelope attack (0 to 1) */
    _attackTime = 0.0;
    /* Length of the volume envelope sustain (0 to 1) */
    _sustainTime = 0.0;
    /* Tilts the sustain envelope for more 'pop' (0 to 1)   */
    _sustainPunch = 0.
    /* Length of the volume envelope decay (yes, I know it's called release) (0 to 1)0;  */
    _decayTime = 0.0;

    /* Base note of the sound (0 to 1) */
    _startFrequency = 0.0
    /* If sliding, the sound will stop at this frequency, to prevent really low notes (0 to 1);  */
    _minFrequency = 0.0;

    /* Slides the note up or down (-1 to 1) */
    _slide = 0.0;
    /* Accelerates the slide (-1 to 1) */
    _deltaSlide = 0.0;

    /* Strength of the vibrato effect (0 to 1) */
    _vibratoDepth = 0.0;
    /* Speed of the vibrato effect (i.e. frequency) (0 to 1) */
    _vibratoSpeed = 0.0;

    /* Shift in note, either up or down (-1 to 1) */
    _changeAmount = 0.0;
    /* How fast the note shift happens (only happens once) (0 to 1)  */
    _changeSpeed = 0.0;

    /* Controls the ratio between the up and down states of the square wave, changing the timbre (0 to 1) */
    _squareDuty = 0.0;
    /* Sweeps the duty up or down (-1 to 1)  */
    _dutySweep = 0.0;

    /* Speed of the note repeating - certain variables are reset each time (0 to 1) */
    _repeatSpeed = 0.0;

    /* Offsets a second copy of the wave by a small phase, changing the timbre (-1 to 1) */
    _phaserOffset = 0.0;
    /* Sweeps the phase up or down (-1 to 1)  */
    _phaserSweep = 0.0;

    /* Frequency at which the low-pass filter starts attenuating higher frequencies (0 to 1) */
    _lpFilterCutoff = 0.0;
    /* Sweeps the low-pass cutoff up or down (-1 to 1) */
    _lpFilterCutoffSweep = 0.0
    /* Changes the attenuation rate for the low-pass filter, changing the timbre (0 to 1);  */
    _lpFilterResonance = 0.0;

    /* Frequency at which the high-pass filter starts attenuating lower frequencies (0 to 1) */
    _hpFilterCutoff = 0.0;
    /* Sweeps the high-pass cutoff up or down (-1 to 1) */
    _hpFilterCutoffSweep = 0.0;

    //--------------------------------------------------------------------------
    //
    //  Getters / Setters
    //
    //--------------------------------------------------------------------------

    /** Shape of the wave (0:square, 1:saw, 2:sin or 3:noise) */
    get waveType() { return this._waveType; }
    set waveType(value) { this._waveType = value > 3 ? 0 : value; this.paramsDirty = true; }

    /** Overall volume of the sound (0 to 1) */
    get masterVolume() { return this._masterVolume; }
    set masterVolume(value) { this._masterVolume = this.clamp1(value); this.paramsDirty = true; }

    /** Length of the volume envelope attack (0 to 1) */
    get attackTime() { return this._attackTime; }
    set attackTime(value) { this._attackTime = this.clamp1(value); this.paramsDirty = true; }

    /** Length of the volume envelope sustain (0 to 1) */
    get sustainTime() { return this._sustainTime; }
    set sustainTime(value) { this._sustainTime = value; this.paramsDirty = true; }

    /** Tilts the sustain envelope for more 'pop' (0 to 1) */
    get sustainPunch() { return this._sustainPunch; }
    set sustainPunch(value) { this._sustainPunch = this.clamp1(value); this.paramsDirty = true; }

    /** Length of the volume envelope decay (yes, I know it's called release) (0 to 1) */
    get decayTime() { return this._decayTime; }
    set decayTime(value) { this._decayTime = this.clamp1(value); this.paramsDirty = true; }

    /** Base note of the sound (0 to 1) */
    get startFrequency() { return this._startFrequency; }
    set startFrequency(value) { this._startFrequency = this.clamp1(value); this.paramsDirty = true; }

    /** If sliding, the sound will stop at this frequency, to prevent really low notes (0 to 1) */
    get minFrequency() { return this._minFrequency; }
    set minFrequency(value) { this._minFrequency = this.clamp1(value); this.paramsDirty = true; }

    /** Slides the note up or down (-1 to 1) */
    get slide() { return this._slide; }
    set slide(value) { this._slide = this.clamp2(value); this.paramsDirty = true; }

    /** Accelerates the slide (-1 to 1) */
    get deltaSlide() { return this._deltaSlide; }
    set deltaSlide(value) { this._deltaSlide = this.clamp2(value); this.paramsDirty = true; }

    /** Strength of the vibrato effect (0 to 1) */
    get vibratoDepth() { return this._vibratoDepth; }
    set vibratoDepth(value) { this._vibratoDepth = this.clamp1(value); this.paramsDirty = true; }

    /** Speed of the vibrato effect (i.e. frequency) (0 to 1) */
    get vibratoSpeed() { return this._vibratoSpeed; }
    set vibratoSpeed(value) { this._vibratoSpeed = this.clamp1(value); this.paramsDirty = true; }

    /** Shift in note, either up or down (-1 to 1) */
    get changeAmount() { return this._changeAmount; }
    set changeAmount(value) { this._changeAmount = this.clamp2(value); this.paramsDirty = true; }

    /** How fast the note shift happens (only happens once) (0 to 1) */
    get changeSpeed() { return this._changeSpeed; }
    set changeSpeed(value) { this._changeSpeed = this.clamp1(value); this.paramsDirty = true; }

    /** Controls the ratio between the up and down states of the square wave, changing the timbre (0 to 1) */
    get squareDuty() { return this._squareDuty; }
    set squareDuty(value) { this._squareDuty = this.clamp1(value); this.paramsDirty = true; }

    /** Sweeps the duty up or down (-1 to 1) */
    get dutySweep() { return this._dutySweep; }
    set dutySweep(value) { this._dutySweep = this.clamp2(value); this.paramsDirty = true; }

    /** Speed of the note repeating - certain variables are reset each time (0 to 1) */
    get repeatSpeed() { return this._repeatSpeed; }
    set repeatSpeed(value) { this._repeatSpeed = this.clamp1(value); this.paramsDirty = true; }

    /** Offsets a second copy of the wave by a small phase, changing the timbre (-1 to 1) */
    get phaserOffset() { return this._phaserOffset; }
    set phaserOffset(value) { this._phaserOffset = this.clamp2(value); this.paramsDirty = true; }

    /** Sweeps the phase up or down (-1 to 1) */
    get phaserSweep() { return this._phaserSweep; }
    set phaserSweep(value) { this._phaserSweep = this.clamp2(value); this.paramsDirty = true; }

    /** Frequency at which the low-pass filter starts attenuating higher frequencies (0 to 1) */
    get lpFilterCutoff() { return this._lpFilterCutoff; }
    set lpFilterCutoff(value) { this._lpFilterCutoff = this.clamp1(value); this.paramsDirty = true; }

    /** Sweeps the low-pass cutoff up or down (-1 to 1) */
    get lpFilterCutoffSweep() { return this._lpFilterCutoffSweep; }
    set lpFilterCutoffSweep(value) { this._lpFilterCutoffSweep = this.clamp2(value); this.paramsDirty = true; }

    /** Changes the attenuation rate for the low-pass filter, changing the timbre (0 to 1) */
    get lpFilterResonance() { return this._lpFilterResonance; }
    set lpFilterResonance(value) { this._lpFilterResonance = this.clamp1(value); this.paramsDirty = true; }

    /** Frequency at which the high-pass filter starts attenuating lower frequencies (0 to 1) */
    get hpFilterCutoff() { return this._hpFilterCutoff; }
    set hpFilterCutoff(value) { this._hpFilterCutoff = this.clamp1(value); this.paramsDirty = true; }

    /** Sweeps the high-pass cutoff up or down (-1 to 1) */
    get hpFilterCutoffSweep() { return this._hpFilterCutoffSweep; }
    hpFilterCutoffSweep(value) { this._hpFilterCutoffSweep = this.clamp2(value); this.paramsDirty = true; }

    //--------------------------------------------------------------------------
    //
    //  Generator Methods
    //
    //--------------------------------------------------------------------------

    /**
     * Sets the parameters to generate a pickup/coin sound
     */
    generatePickupCoin() {
        this.resetParams();

        this._startFrequency = 0.4 + Math.random() * 0.5;

        this._sustainTime = Math.random() * 0.1;
        this._decayTime = 0.1 + Math.random() * 0.4;
        this._sustainPunch = 0.3 + Math.random() * 0.3;

        if (Math.random() < 0.5) {
            this._changeSpeed = 0.5 + Math.random() * 0.2;
            this._changeAmount = 0.2 + Math.random() * 0.4;
        }
    }

    /**
     * Sets the parameters to generate a laser/shoot sound
     */
    generateLaserShoot() {
        this.resetParams();

        this._waveType = Math.random() * 3 | 0;
        if (this._waveType == 2 && Math.random() < 0.5) this._waveType = Math.random() * 2 | 0;

        this._startFrequency = 0.5 + Math.random() * 0.5;
        this._minFrequency = this._startFrequency - 0.2 - Math.random() * 0.6;
        if (this._minFrequency < 0.2) this._minFrequency = 0.2;

        this._slide = -0.15 - Math.random() * 0.2;

        if (Math.random() < 0.33) {
            this._startFrequency = 0.3 + Math.random() * 0.6;
            this._minFrequency = Math.random() * 0.1;
            this._slide = -0.35 - Math.random() * 0.3;
        }

        if (Math.random() < 0.5) {
            this._squareDuty = Math.random() * 0.5;
            this._dutySweep = Math.random() * 0.2;
        }
        else {
            this._squareDuty = 0.4 + Math.random() * 0.5;
            this._dutySweep = - Math.random() * 0.7;
        }

        this._sustainTime = 0.1 + Math.random() * 0.2;
        this._decayTime = Math.random() * 0.4;
        if (Math.random() < 0.5) this._sustainPunch = Math.random() * 0.3;

        if (Math.random() < 0.33) {
            this._phaserOffset = Math.random() * 0.2;
            this._phaserSweep = -Math.random() * 0.2;
        }

        if (Math.random() < 0.5) this._hpFilterCutoff = Math.random() * 0.3;
    }

    /**
     * Sets the parameters to generate an explosion sound
     */
    generateExplosion() {
        this.resetParams();
        this._waveType = 3;

        if (Math.random() < 0.5) {
            this._startFrequency = 0.1 + Math.random() * 0.4;
            this._slide = -0.1 + Math.random() * 0.4;
        }
        else {
            this._startFrequency = 0.2 + Math.random() * 0.7;
            this._slide = -0.2 - Math.random() * 0.2;
        }

        this._startFrequency *= this._startFrequency;

        if (Math.random() < 0.2) this._slide = 0.0;
        if (Math.random() < 0.33) this._repeatSpeed = 0.3 + Math.random() * 0.5;

        this._sustainTime = 0.1 + Math.random() * 0.3;
        this._decayTime = Math.random() * 0.5;
        this._sustainPunch = 0.2 + Math.random() * 0.6;

        if (Math.random() < 0.5) {
            this._phaserOffset = -0.3 + Math.random() * 0.9;
            this._phaserSweep = -Math.random() * 0.3;
        }

        if (Math.random() < 0.33) {
            this._changeSpeed = 0.6 + Math.random() * 0.3;
            this._changeAmount = 0.8 - Math.random() * 1.6;
        }
    }

    /**
     * Sets the parameters to generate a power up sound
     */
    generatePowerUp() {
        this.resetParams();

        if (Math.random() < 0.5) this._waveType = 1;
        else this._squareDuty = Math.random() * 0.6;

        if (Math.random() < 0.5) {
            this._startFrequency = 0.2 + Math.random() * 0.3;
            this._slide = 0.1 + Math.random() * 0.4;
            this._repeatSpeed = 0.4 + Math.random() * 0.4;
        }
        else {
            this._startFrequency = 0.2 + Math.random() * 0.3;
            this._slide = 0.05 + Math.random() * 0.2;

            if (Math.random() < 0.5) {
                this._vibratoDepth = Math.random() * 0.7;
                this._vibratoSpeed = Math.random() * 0.6;
            }
        }

        this._sustainTime = Math.random() * 0.4;
        this._decayTime = 0.1 + Math.random() * 0.4;
    }

    /**
     * Sets the parameters to generate a hit/hurt sound
     */
    generateHitHurt() {
        this.resetParams();

        this._waveType = Math.random() * 3 | 0;
        if (this._waveType == 2) this._waveType = 3;
        else if (this._waveType == 0) this._squareDuty = Math.random() * 0.6;

        this._startFrequency = 0.2 + Math.random() * 0.6;
        this._slide = -0.3 - Math.random() * 0.4;

        this._sustainTime = Math.random() * 0.1;
        this._decayTime = 0.1 + Math.random() * 0.2;

        if (Math.random() < 0.5) this._hpFilterCutoff = Math.random() * 0.3;
    }

    /**
     * Sets the parameters to generate a jump sound
     */
    generateJump() {
        this.resetParams();

        this._waveType = 0;
        this._squareDuty = Math.random() * 0.6;
        this._startFrequency = 0.3 + Math.random() * 0.3;
        this._slide = 0.1 + Math.random() * 0.2;

        this._sustainTime = 0.1 + Math.random() * 0.3;
        this._decayTime = 0.1 + Math.random() * 0.2;

        if (Math.random() < 0.5) this._hpFilterCutoff = Math.random() * 0.3;
        if (Math.random() < 0.5) this._lpFilterCutoff = 1.0 - Math.random() * 0.6;
    }

    /**
     * Sets the parameters to generate a blip/select sound
     */
    generateBlipSelect() {
        this.resetParams();

        this._waveType = Math.random() * 2 | 0;
        if (this._waveType == 0) this._squareDuty = Math.random() * 0.6;

        this._startFrequency = 0.2 + Math.random() * 0.4;

        this._sustainTime = 0.1 + Math.random() * 0.1;
        this._decayTime = Math.random() * 0.2;
        this._hpFilterCutoff = 0.1;
    }

    /**
     * Resets the parameters, used at the start of each generate function
     */
    resetParams() {
        this.paramsDirty = true;

        this._waveType = 0;
        this._startFrequency = 0.3;
        this._minFrequency = 0.0;
        this._slide = 0.0;
        this._deltaSlide = 0.0;
        this._squareDuty = 0.0;
        this._dutySweep = 0.0;

        this._vibratoDepth = 0.0;
        this._vibratoSpeed = 0.0;

        this._attackTime = 0.0;
        this._sustainTime = 0.3;
        this._decayTime = 0.4;
        this._sustainPunch = 0.0;

        this._lpFilterResonance = 0.0;
        this._lpFilterCutoff = 1.0;
        this._lpFilterCutoffSweep = 0.0;
        this._hpFilterCutoff = 0.0;
        this._hpFilterCutoffSweep = 0.0;

        this._phaserOffset = 0.0;
        this._phaserSweep = 0.0;

        this._repeatSpeed = 0.0;

        this._changeSpeed = 0.0;
        this._changeAmount = 0.0;
    }

    //--------------------------------------------------------------------------
    //
    //  Randomize Methods
    //
    //--------------------------------------------------------------------------

    /**
     * Randomly adjusts the parameters ever so slightly
     */
    mutate(mutation = 0.05) {
        if (Math.random() < 0.5) startFrequency += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) slide += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) deltaSlide += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) squareDuty += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) dutySweep += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) vibratoDepth += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) vibratoSpeed += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) attackTime += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) sustainTime += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) decayTime += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) sustainPunch += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) lpFilterCutoff += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) lpFilterCutoffSweep += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) lpFilterResonance += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) hpFilterCutoff += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) hpFilterCutoffSweep += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) phaserOffset += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) phaserSweep += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) repeatSpeed += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) changeSpeed += Math.random() * mutation * 2 - mutation;
        if (Math.random() < 0.5) changeAmount += Math.random() * mutation * 2 - mutation;
    }

    randomize() {
        this.paramsDirty = true;

        this._waveType = Math.random() * 4 | 0;

        this._attackTime = this.pow(Math.random() * 2 - 1, 4);
        this._sustainTime = this.pow(Math.random() * 2 - 1, 2);
        this._sustainPunch = this.pow(Math.random() * 0.8, 2);
        this._decayTime = Math.random();

        this._startFrequency = (Math.random() < 0.5) ? this.pow(Math.random() * 2 - 1, 2) : (this.pow(Math.random() * 0.5, 3) + 0.5);
        this._minFrequency = 0.0;

        this._slide = this.pow(Math.random() * 2 - 1, 5);
        this._deltaSlide = this.pow(Math.random() * 2 - 1, 3);

        this._vibratoDepth = this.pow(Math.random() * 2 - 1, 3);
        this._vibratoSpeed = Math.random() * 2 - 1;

        this._changeAmount = Math.random() * 2 - 1;
        this._changeSpeed = Math.random() * 2 - 1;

        this._squareDuty = Math.random() * 2 - 1;
        this._dutySweep = this.pow(Math.random() * 2 - 1, 3);

        this._repeatSpeed = Math.random() * 2 - 1;

        this._phaserOffset = this.pow(Math.random() * 2 - 1, 3);
        this._phaserSweep = this.pow(Math.random() * 2 - 1, 3);

        this._lpFilterCutoff = 1 - this.pow(Math.random(), 3);
        this._lpFilterCutoffSweep = this.pow(Math.random() * 2 - 1, 3);
        this._lpFilterResonance = Math.random() * 2 - 1;

        this._hpFilterCutoff = this.pow(Math.random(), 5);
        this._hpFilterCutoffSweep = this.pow(Math.random() * 2 - 1, 5);

        if (this._attackTime + this._sustainTime + this._decayTime < 0.2) {
            this._sustainTime = 0.2 + Math.random() * 0.3;
            this._decayTime = 0.2 + Math.random() * 0.3;
        }

        if ((this._startFrequency > 0.7 && this._slide > 0.2) || (this._startFrequency < 0.2 && this._slide < -0.05)) {
            this._slide = -this._slide;
        }

        if (this._lpFilterCutoff < 0.1 && this._lpFilterCutoffSweep < -0.05) {
            this._lpFilterCutoffSweep = -this._lpFilterCutoffSweep;
        }
    }

    /**
     * Parses a settings string into the parameters
     * @param    string    Settings string to parse
     * @return            If the string successfully parsed
     */
    setSettingsString(string) {
        var values = string.split(",");

        if (values.length != 24) return false;

        this.waveType = parseInt(values[0]) || 0;
        this.attackTime = parseFloat(values[1]) || 0;
        this.sustainTime = parseFloat(values[2]) || 0;
        this.sustainPunch = parseFloat(values[3]) || 0;
        this.decayTime = parseFloat(values[4]) || 0;
        this.startFrequency = parseFloat(values[5]) || 0;
        this.minFrequency = parseFloat(values[6]) || 0;
        this.slide = parseFloat(values[7]) || 0;
        this.deltaSlide = parseFloat(values[8]) || 0;
        this.vibratoDepth = parseFloat(values[9]) || 0;
        this.vibratoSpeed = parseFloat(values[10]) || 0;
        this.changeAmount = parseFloat(values[11]) || 0;
        this.changeSpeed = parseFloat(values[12]) || 0;
        this.squareDuty = parseFloat(values[13]) || 0;
        this.dutySweep = parseFloat(values[14]) || 0;
        this.repeatSpeed = parseFloat(values[15]) || 0;
        this.phaserOffset = parseFloat(values[16]) || 0;
        this.phaserSweep = parseFloat(values[17]) || 0;
        this.lpFilterCutoff = parseFloat(values[18]) || 0;
        this.lpFilterCutoffSweep = parseFloat(values[19]) || 0;
        this.lpFilterResonance = parseFloat(values[20]) || 0;
        this.hpFilterCutoff = parseFloat(values[21]) || 0;
        this.hpFilterCutoffSweep = parseFloat(values[22]) || 0;
        this.masterVolume = parseFloat(values[23]) || 0;

        return true;
    }


    //--------------------------------------------------------------------------
    //
    //  Copying Methods
    //
    //--------------------------------------------------------------------------

    /**
     * Returns a copy of this SfxrParams with all settings duplicated
     * @return    A copy of this SfxrParams
     */
    clone() {
        var out = new SfxrParams();
        out.copyFrom(this);

        return out;
    }

    /**
     * Copies parameters from another instance
     * @param    params    Instance to copy parameters from
     */
    copyFrom(params, makeDirty = false) {
        this._waveType = params.waveType;
        this._attackTime = params.attackTime;
        this._sustainTime = params.sustainTime;
        this._sustainPunch = params.sustainPunch;
        this._decayTime = params.decayTime;
        this._startFrequency = params.startFrequency;
        this._minFrequency = params.minFrequency;
        this._slide = params.slide;
        this._deltaSlide = params.deltaSlide;
        this._vibratoDepth = params.vibratoDepth;
        this._vibratoSpeed = params.vibratoSpeed;
        this._changeAmount = params.changeAmount;
        this._changeSpeed = params.changeSpeed;
        this._squareDuty = params.squareDuty;
        this._dutySweep = params.dutySweep;
        this._repeatSpeed = params.repeatSpeed;
        this._phaserOffset = params.phaserOffset;
        this._phaserSweep = params.phaserSweep;
        this._lpFilterCutoff = params.lpFilterCutoff;
        this._lpFilterCutoffSweep = params.lpFilterCutoffSweep;
        this._lpFilterResonance = params.lpFilterResonance;
        this._hpFilterCutoff = params.hpFilterCutoff;
        this._hpFilterCutoffSweep = params.hpFilterCutoffSweep;
        this._masterVolume = params.masterVolume;

        if (makeDirty) this.paramsDirty = true;
    }

    toObject() {
        return {
            oldParams: true,
            wave_type: this.waveType,
            p_env_attack: this.attackTime,
            p_env_sustain: this.sustainTime,
            p_env_punch: this.sustainPunch,
            p_env_decay: this.decayTime,
            p_base_freq: this.startFrequency,
            p_freq_limit: this._minFrequency,
            p_freq_ramp: this.slide,
            p_freq_dramp: this.deltaSlide,
            p_vib_strength: this.vibratoDepth,
            p_vib_speed: this.vibratoSpeed,
            p_arp_mod: this.changeAmount,
            p_arp_speed: this.changeSpeed,
            p_duty: this.squareDuty,
            p_duty_ramp: this.dutySweep,
            p_repeat_speed: this.repeatSpeed,
            p_pha_offset: this.phaserOffset,
            p_pha_ramp: this.phaserSweep,
            p_lpf_freq: this.lpFilterCutoff,
            p_lpf_ramp: this.lpFilterCutoffSweep,
            p_lpf_resonance: this.lpFilterResonance,
            p_hpf_freq: this.hpFilterCutoff,
            p_hpf_ramp: this.hpFilterCutoffSweep,
            sound_vol: this.masterVolume,
            sample_rate: 44100,
            sample_size: 8
        };
    }


    //--------------------------------------------------------------------------
    //
    //  Util Methods
    //
    //--------------------------------------------------------------------------

    /**
     * Clams a value to between 0 and 1
     * @param    value    Input value
     * @return            The value clamped between 0 and 1
     */
    clamp1(value) { return (value > 1.0) ? 1.0 : ((value < 0.0) ? 0.0 : value); }

    /**
     * Clams a value to between -1 and 1
     * @param    value    Input value
     * @return            The value clamped between -1 and 1
     */
    clamp2(value) { return (value > 1.0) ? 1.0 : ((value < -1.0) ? -1.0 : value); }

    /**
     * Quick power function
     * @param    base        Base to raise to power
     * @param    power        Power to raise base by
     * @return                The calculated power
     */
    pow(base, power) {
        switch (power) {
            case 2: return base * base;
            case 3: return base * base * base;
            case 4: return base * base * base * base;
            case 5: return base * base * base * base * base;
        }

        return 1.0;
    }


    /**
     * Returns the number as a string to 4 decimal places
     * @param    value    Number to convert
     * @return            Number to 4dp as a string
     */
    to4DP(value) {
        if (value < 0.0001 && value > -0.0001) return "";

        var string = String(value);
        var split = string.split(".");
        if (split.length == 1) {
            return string;
        }
        else {
            var out = split[0] + "." + split[1].substr(0, 4);
            while (out.substr(out.length - 1, 1) == "0") out = out.substr(0, out.length - 1);

            return out;
        }
    }
}