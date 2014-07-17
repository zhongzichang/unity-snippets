using UnityEngine;
using System.Collections;

/// <summary>
///   位于 XY 平面的散射
/// </summary>
public class DirectionalScatter : MonoBehaviour {

  /// <summary>
  ///   每一个被发射物体之间的角度差异
  /// </summary>
  public const float SEP_ANGLE = 10f;

  public GameObject projectile;
  public int particleCount = 3;
  public Vector3 direction = Vector3.right;

  private Transform myTransform;
  private float halfSepAngle = SEP_ANGLE / 2;


	// Use this for initialization
	void Awake () {
    myTransform = transform;
	}

  void Start()
  {
    StartCoroutine( SimulateProjectile());
  }
	

  IEnumerator SimulateProjectile()
  {
    yield return new WaitForSeconds(1.5F);

    // 是奇数还是偶数
    bool isEven = false;
    if (particleCount % 2 == 0) {
      isEven = true;
    }

    // 扇形中轴线的 rotation
    Quaternion middleQuat = Quaternion.LookRotation (direction);
    Quaternion[] quats = new Quaternion[particleCount];
    if (isEven) {
      // 粒子的数量为偶数
      // 中轴线上无发射物
      int half = particleCount / 2;
      for (int i = 0; i < half; i++) {
        quats [i*2] = middleQuat * Quaternion.AngleAxis (SEP_ANGLE * i + halfSepAngle, Vector3.right);
        quats [i*2+1] = middleQuat * Quaternion.AngleAxis (-((SEP_ANGLE * i) + halfSepAngle), Vector3.right);
      }
    } else {
      // 粒子的数量为奇数
      // 中轴线上有发射物
      quats [0] = middleQuat;
      int half = (particleCount - 1) / 2;
      for (int i = 0; i < half; i++) {
        quats [i*2+1] = middleQuat * Quaternion.AngleAxis (SEP_ANGLE * (i+1), Vector3.right);
        quats [i*2+2] = middleQuat * Quaternion.AngleAxis (-SEP_ANGLE * (i+1), Vector3.right);
      }
    }

    if (quats.Length > 0) {
      // 抛出子作用器 ---
      for(int i=0; i<particleCount; i++ )
        {
          GameObject g = GameObject.Instantiate(projectile) as GameObject;
          g.transform.rotation = quats[i];
          g.transform.Translate( 0, 0, 5f);
          
        }
    }

  }

}
