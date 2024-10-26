import { existsSync, rmSync, unlinkSync, writeFileSync } from 'node:fs';
import sfxr from 'jsfxr'
import { SfxrParams } from "./sfxrParams.js";
import { join } from 'node:path';
import { exec } from 'node:child_process';

const __dirname = import.meta.dirname;

(async function(){
    await writeMany(
        'Games/2011-09-28-Galaxus/Source_AS3/assets/sfx/',
        {
			sfxRollOver: "2,0.0051,0.0252,,0.21,0.29,0.0752,,,,,,0.89,0.4339,,,,,1,,,,,0.2",
			sfxClick: "2,,0.186,,0.0638,0.5582,,,,,,,,,,,,,1,,,0.1,,0.2",
			sfxFire: "1,,0.13,,0.24,0.48,0.2,-0.3,,0.31,0.52,0.54,,0.681,-0.24,,-0.4,0.3,1,,,,,0.17",
			sfxExplode: "3,,0.34,0.25,0.27,0.1746,,0.0986,,,,,,,,0.7233,,,1,,,,,0.17",
			sfxEnFire: "0,,0.2028,0.2366,0.2398,0.7515,0.0673,-0.4,,,,,,1,-0.6599,,0.0557,-0.1727,1,,,,,0.17",
			sfxDamage: "3,,0.0877,,0.1188,0.3671,,-0.453,,,,,,,,,,,1,,,,,0.17",
			sfxCoin: "0,,0.01,0.16,0.32,0.55,,,,,,0.6399,0.74,,,,,,1,,,,,0.17",
        }
    )
    await writeMany(
        'Games/2011-04-19-Kulkis/Source_AS3/assets/sfx/sfxr/',
        {
            blockBoom: "3,,0.3563,0.4426,0.13,0.2216,,-0.2897,,,,-0.506,0.8443,,,,,,1,,,,,0.1",
            playerBounce: "0,,0.027,,0.2638,0.4521,,-0.6317,,,,,,0.3518,,,,,1,,,0.1684,,0.1",
            levelCompleted: "2,,0.01,,1,0.41,,0.34,0.6799,0.35,0.66,,0.63,0.1344,,0.58,,,0.42,,,,,0.1",
            rollOver: "2,0.0051,0.0252,,0.21,0.29,0.0752,,,,,,0.89,0.4339,,,,,1,,,,,0.1",
            click: "2,,0.186,,0.0638,0.5582,,,,,,,,,,,,,1,,,0.1,,0.1",
            death: "3,,0.1764,0.6369,0.4858,0.1138,,0.2251,,0.56,0.47,0.3912,0.6772,,,0.75,,,1,,,,,0.1",
            changeColor: "0,,0.25,0.2,0.63,0.56,,,,0.3,0.72,,0.16,,,,,,0.61,-0.1999,,,,0.1",
        }
    )
    await writeMany(
        'Games/2011-08-27-Kulkis1_5/Source_AS3/assets/sfx/sfxr/',
        {
            blockBoom: "3,,0.3563,0.4426,0.13,0.2216,,-0.2897,,,,-0.506,0.8443,,,,,,1,,,,,0.50",
            playerBounce: "0,,0.027,,0.2638,0.4521,,-0.6317,,,,,,0.3518,,,,,1,,,0.1684,,0.50",
            levelCompleted: "2,,0.01,,1,0.41,,0.34,0.6799,0.35,0.66,,0.63,0.1344,,0.58,,,0.42,,,,,0.2",
            rollOver: "2,0.0051,0.0252,,0.21,0.29,0.0752,,,,,,0.89,0.4339,,,,,1,,,,,0.2",
            click: "2,,0.186,,0.0638,0.5582,,,,,,,,,,,,,1,,,0.1,,0.2",
            death: "3,,0.1764,0.6369,0.4858,0.1138,,0.2251,,0.56,0.47,0.3912,0.6772,,,0.75,,,1,,,,,0.2",
            changeColor: "0,,0.25,0.2,0.63,0.56,,,,0.3,0.72,,0.16,,,,,,0.61,-0.1999,,,,0.17",
            diamond: "0,,0.0921,0.5323,0.2098,0.4575,,,,0.16,0.47,,,0.63,0.26,,,,0.71,0.5,0.25,,,0.17",
        }
    );
    await writeMany(
        'Games/2011-08-16-RockRush/Source_AS3/assets/sfx/sfxr/',
        {
            sfxRollOver: "2,0.0051,0.0252,,0.21,0.29,0.0752,,,,,,0.89,0.4339,,,,,1,,,,,0.15",
            sfxClick: "2,,0.186,,0.0638,0.5582,,,,,,,,,,,,,1,,,0.1,,0.15",
            sfxWalk: "3,,0.18,,,0.216,,,,,,,,,-0.62,,,,0.69,-0.4,,,1,0.1",
            sfxAlert: "1,,0.31,0.55,0.39,0.16,,,,,,,,0.1362,,,,,1,,,0.1,,0.1",
            sfxTimeCount: "0,,2,,1,0.64,,-0.0799,,0.34,0.54,,,0.58,,,,,1,,,,,0.1",
        }
    );
    await writeMany(
        'Games/2011-07-02-LinxFlash/Source_AS3/assets/sfx/',
        {
            sfxRollOver: "2,0.0051,0.0252,,0.21,0.29,0.0752,,,,,,0.89,0.4339,,,,,1,,,,,0.22",
            sfxClick: "2,,0.186,,0.0638,0.5582,,,,,,,,,,,,,1,,,0.1,,0.22",
            sfxPlacePath: "3,,0.01,,0.3,0.4,,-0.6799,,0.93,,-0.78,,0.347,,0.11,-0.78,-1,0.44,-1,0.02,0.27,,0.2",
            sfxGotMatch: "0,,0.2541,,0.42,0.63,,,,0.27,0.53,,,0.51,0.76,0.66,,,0.73,,,,,0.2",
            sfxLevelCompleted: "2,,0.2314,,0.69,0.4534,,0.1599,,0.98,0.45,,,0.1809,,,,,1,,,,,0.2",
            sfxRemovePath: "0,,0.1841,,0.4,0.4871,,-0.38,,,,,,0.1862,,,,,1,,,0.1,,0.2",
        }
    )
    await writeMany(
        'Games/2012-09-11-CyberKulkis/Source_AS3/assets/sfx/',
        {

            sfxRollOver: "2,0.0051,0.0252,,0.21,0.29,0.0752,,,,,,0.89,0.4339,,,,,1,,,,,0.20",
            sfxClick: "2,,0.186,,0.0638,0.5582,,,,,,,,,,,,,1,,,0.1,,0.20",
        }
    )
    await writeMany(
        'Games/2012-11-06-LinxMobile/Source_AS3/assets/sfx/',
        {
            sfxRollOver: "2,0.0051,0.0252,,0.21,0.29,0.0752,,,,,,0.89,0.4339,,,,,1,,,,,0.2",
            sfxClick: "2,,0.186,,0.0638,0.5582,,,,,,,,,,,,,1,,,0.1,,0.2",
            sfxPlacePath: "3,,0.01,,0.3,0.4,,-0.6799,,0.93,,-0.78,,0.347,,0.11,-0.78,-1,0.44,-1,0.02,0.27,,0.18",
            sfxGotMatch: "0,,0.2541,,0.42,0.63,,,,0.27,0.53,,,0.51,0.76,0.66,,,0.73,,,,,0.18",
            sfxLevelCompleted: "2,,0.2314,,0.69,0.4534,,0.1599,,0.98,0.45,,,0.1809,,,,,1,,,,,0.18",
            sfxRemovePath: "0,,0.1841,,0.4,0.4871,,-0.38,,,,,,0.1862,,,,,1,,,0.1,,0.18",
            sfxError: "1,0.25,0.32,0.21,0.13,0.24,,,,0.64,0.45,,,0.64,-0.7,,-0.3,0.6,0.58,1,0.7,,0.4399,0.18",
        }
    )
})().then(
    () => console.log("Operation finished"),
    error => console.log("Error: ", error)
)

async function writeMany(dir, pairs) {
    dir = join(__dirname, '..', '..', dir);

    console.log("Generating for " + dir);
    if (!existsSync(dir)) {
        throw new Error(`Invalid directory ${dir}`)
    }
    for (const [file, paramString] of Object.entries(pairs)) {
        await write(join(dir, file), paramString);
    }
}
async function write(baseFileName, paramString) {
    const fileNameWav = baseFileName + ".wav";
    const fileNameMp3 = baseFileName + ".mp3";

    console.log("Generating " + fileNameMp3);

    if (existsSync(fileNameWav)) {
        unlinkSync(fileNameWav);
    }
    if (existsSync(fileNameMp3)) {
        unlinkSync(fileNameMp3);
    }

    const params = new SfxrParams();
    params.setSettingsString(paramString);

    var sound = new sfxr.SoundEffect(params.toObject()).generate();
    var index = sound.dataURI.indexOf('base64,');
    var data = sound.dataURI.substring(index + 7);
    const decodedLength = Buffer.byteLength(data, 'base64');
    const buffer = Buffer.alloc(decodedLength);
    Buffer.from(data, 'base64').copy(buffer);

    writeFileSync(fileNameWav, buffer);

    return new Promise(resolve => {
        exec(`ffmpeg -i ${fileNameWav} -codec:a libmp3lame -qscale:a 0 ${fileNameMp3}`, () => {
            console.log("Generated mp3");
            rmSync(fileNameWav);
            resolve();
        });
    })

}